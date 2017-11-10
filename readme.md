Mura Google Sitemaps Plugin

The Google Sitemaps Plugin generates Google-compatible sitemaps for a Mura CMS website. Sitemaps are xml documents that the Google site crawler will use to properly and efficiently document your website. You can find details on Google Sitemaps on their website. This plugin replaces the Meld Google Sitemaps plugin, which is now deprecated.

Installation

If you have that plugin, you should uninstall that plugin first, then install this one. Page-level settings are similar, so you shouldn't have to do anything but update the settings (Step 4).

To install the Mura Google Sitemaps plugin:

-Uninstall Meld Google Sitemaps (if you have it installed)

-Click on Plugins > Add Plugin in your Mura CMS administrator

-Either

   -download the plugin from the BlueRiver GitHub repository and click Choose File

   -(or) click on Via URL and type in https://github.com/blueriver/MuraGoogleSitemaps/archive/master.zip

-Click on Deploy

-Agree to the License

-Select any sites that you want to generate sitemaps for

-Click on Save

Setup

The first thing you should do once the plugin is installed is update the settings. Set Enabled to yes, select the update frequency (the scheduler will generate the sitemap automatically for you every day at 3AM), and choose the location for your sitemap:

-Web Root: Google looks here automatically. If you have multiple Mura sites, you will have to choose one of the next two options.

-Site Root: Useful if you have multiple sites in your Mura instance. You will have to register your sitemaps with Google here.

-Custom: If you need to put your sitemap in a custom location, use this option to enter the full directory path to where you want the file written.

By default, the Mura Google Sitemap plugin will include all pages in your website. You can customize this on a per-page or per-section basis by clicking on the Extended Attributes tab in the content editor, and adjusting the Google Sitemaps settings:

-Exclude From Sitemap: by default all pages are included. Select "No" to exclude the page, "Yes" to include the page, and "Inherit" to inherit whatever the parent page's settings are.

-Change Frequency: this tells Google how often it should re-index the page.

-Priority: This is the priority weight you would like placed on the page. For instance, your homepage should be a 1.0, your contact us page should be similarly high, with the rest of the site weighted accordingly (note that it is questionable how valuable this weighting system is in regards to your site, so I wouldn't lose too much sleep over it).

Generation

The Mura Sitemaps plugin uses your cfml engine's scheduler to automatically generate your sitemap as per your setup instructions. If you'd like to alter that schedule, you can go to your cfml administrator and edit it to suit your needs.

You can also manually generate the sitemap at any time by clicking on the Generate tab and then the Generate button at the bottom of the page.

News

You can also generate news sitemaps. If your site generates news compatible with Google's guidelines, you can enable this feature under the News tab. Set Enabled to turn this feature on, and then select an existing Content Collection that will act as a source for the news sitemap. Note that as per the Google news sitemap regulations, the sitemap will only contain items published within the last two days. Also, this sitemap is generate on a daily schedule as well as every time you click on the manual Generate button (see above).

Translations

If you have the Mura Translations plugin installed, the Mura Google Sitemaps plugin will also generate translated references for you as well. Simply click on the Translations tab and select the language sites you wish to include in your sitemap.
