Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 08:31:25 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.179]:58263 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023353AbXLQIbR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Dec 2007 08:31:17 +0000
Received: by wa-out-1112.google.com with SMTP id m16so3066282waf.20
        for <linux-mips@linux-mips.org>; Mon, 17 Dec 2007 00:31:05 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=7VRmMX7iKjii4EkYWS3w18NfmrZAQgrMcgDs6rdXJVQ=;
        b=cUEh1H38RsObAmfkwUzyCwRvKt7rfu1uHChemRAhIb25V77TPdadL0UngwrFH1UBwNdapD5PsqMksQtupkeGzpQcboxdSmo0HnFVwr1Zyw8VsqTuAOi0UbyzG1V5IQQlejdc2hcmYPE7ILsX4mbKpXInDrCV1X7CRdOZZsAQrXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=QSFaIBDpYlFea09dK4la6hsoo63ga3WFSJ9nIx/l+W7EAYMwUjsBaVRIyKkFUR7QO/OEw9GRj+N57LMoRc4y2Vmyl+IIhr4KjtcZsrxIsmhy0QsXZNDnj7xnEeYCbzRYfyEPtu8LV5siwMoQFFb6pbJruJDHpCoQWY1p5X0Rdjs=
Received: by 10.114.67.2 with SMTP id p2mr2125175waa.1.1197880265213;
        Mon, 17 Dec 2007 00:31:05 -0800 (PST)
Received: by 10.114.135.8 with HTTP; Mon, 17 Dec 2007 00:31:05 -0800 (PST)
Message-ID: <eea8a9c90712170031i62e4ac4ak687a198200f59920@mail.gmail.com>
Date:	Mon, 17 Dec 2007 14:01:05 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	celinux-dev@tree.celinuxforum.org,
	linux-fbdev-users@lists.sourceforge.net,
	directfb-users@directfb.org, directfb-dev@directfb.org
Subject: Error in running gtk example on cross compiled GTK with DirectFB on MIPS board
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5204_15501233.1197880265204"
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_5204_15501233.1197880265204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

HI ALL,

We have successfully cross compiled GTK and DIRECTFB with all its
dependencies for MIPS board.
On running the basic test example of GTK, it is getting struck in the thread
loop infinitely.
We had put the  "debug printf"  statement in the gtkmain.c and debugged the
test example.
It is getting struck in the * g_main_loop_run (loop);* given below is
the  code(code
snippet from gtkmain.c)

void
gtk_main (void)
{
  GList *tmp_list;
  GList *functions;
  GtkInitFunction *init;
  GMainLoop *loop;
printf("\n%s :: %d\n",__FILE__,__LINE__);
  gtk_main_loop_level++;

  loop = g_main_loop_new (NULL, TRUE);
  main_loops = g_slist_prepend (main_loops, loop);
printf("\n%s :: %d\n",__FILE__,__LINE__);
  tmp_list = functions = init_functions;
  init_functions = NULL;

  while (tmp_list)
    {
      init = tmp_list->data;
      tmp_list = tmp_list->next;

      (* init->function) (init->data);
      g_free (init);
    }
  g_list_free (functions);
printf("\n%s :: %d\n",__FILE__,__LINE__);
  if (g_main_loop_is_running (main_loops->data))
    {
   * printf("\n%s :: %d\n",__FILE__,__LINE__);
      GDK_THREADS_LEAVE ();
      g_main_loop_run (loop);
      GDK_THREADS_ENTER ();
*      printf("\n%s :: %d\n",__FILE__,__LINE__);
      gdk_flush ();
    }
printf("\n%s :: %d\n",__FILE__,__LINE__);
  if (quit_functions)
    {
      GList *reinvoke_list = NULL;
      GtkQuitFunction *quitf;



Given below is the src code for test example of GTK:


#include <gtk/gtk.h>

int main( int   argc, char *argv[] )
{
	GtkWidget *window;
	GtkWidget *pMainWidget;
	GdkPixbuf *image;
	gboolean ret = 0;
	gtk_init (&argc, &argv);
printf("\n\n\ngtk_init (&argc, &argv);\n\n\n");		
	window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
	
	//gtk_container_set_border_width (GTK_CONTAINER (window), 10);
	
	image  = gdk_pixbuf_new_from_file ("test.gif", NULL);
   	if (!image)
		return FALSE;
   	pMainWidget = gtk_image_new_from_pixbuf(image);
printf("\n\n\npMainWidget = gtk_image_new_from_pixbuf(image);\n\n\n");	
	gtk_widget_show (pMainWidget);
	
	gtk_container_add (GTK_CONTAINER (window), pMainWidget);
 printf("\n\n\ngtk_container_add (GTK_CONTAINER (window),
pMainWidget);\n\n\n") ;
	gtk_widget_show (window);
printf("\n\n\nABHISHEK START OF gtk_main\n\n\n");	
	gtk_main ();
printf("\n\n\nABHISHEK END OF gtk_main\n\n\n");
	return 0;
}

Can anybody Plz throw some light on it?
Thanks in advcance
-- 
Thanks & Regards,
kaka

------=_Part_5204_15501233.1197880265204
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>HI ALL,</div>
<div>&nbsp;</div>
<div>We have successfully cross compiled GTK and DIRECTFB with all its dependencies for MIPS board.</div>
<div>On running the basic test example of GTK, it is getting struck in the thread loop infinitely.</div>
<div>We had put the &nbsp;&quot;debug printf&quot;&nbsp; statement in the gtkmain.c and debugged the test example.</div>
<div>It is getting struck in the&nbsp;<font color="#000099"><strong> g_main_loop_run (loop);</strong> <font color="#330033">given below&nbsp;is the</font> </font>&nbsp;code(code snippet from gtkmain.c)</div>
<div>&nbsp;</div>
<div>void<br>gtk_main (void)<br>{<br>&nbsp; GList *tmp_list;<br>&nbsp; GList *functions;<br>&nbsp; GtkInitFunction *init;<br>&nbsp; GMainLoop *loop;<br>printf(&quot;\n%s :: %d\n&quot;,__FILE__,__LINE__);<br>&nbsp; gtk_main_loop_level++;<br>&nbsp; <br>
&nbsp; loop = g_main_loop_new (NULL, TRUE);<br>&nbsp; main_loops = g_slist_prepend (main_loops, loop);<br>printf(&quot;\n%s :: %d\n&quot;,__FILE__,__LINE__);<br>&nbsp; tmp_list = functions = init_functions;<br>&nbsp; init_functions = NULL;<br>
&nbsp; <br>&nbsp; while (tmp_list)<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init = tmp_list-&gt;data;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_list = tmp_list-&gt;next;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (* init-&gt;function) (init-&gt;data);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_free (init);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp; g_list_free (functions); 
<br>printf(&quot;\n%s :: %d\n&quot;,__FILE__,__LINE__);<br>&nbsp; if (g_main_loop_is_running (main_loops-&gt;data))<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;<strong><font color="#000099"> printf(&quot;\n%s :: %d\n&quot;,__FILE__,__LINE__);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GDK_THREADS_LEAVE (); 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_main_loop_run (loop);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GDK_THREADS_ENTER ();<br></font></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;\n%s :: %d\n&quot;,__FILE__,__LINE__);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gdk_flush ();<br>&nbsp;&nbsp;&nbsp; }<br>printf(&quot;\n%s :: %d\n&quot;,__FILE__,__LINE__); 
<br>&nbsp; if (quit_functions)<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GList *reinvoke_list = NULL;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GtkQuitFunction *quitf;<br><br></div>
<div>&nbsp;</div>
<div><br clear="all">Given below is the src code for test example of GTK:</div>
<div>&nbsp;</div>
<div><pre>#include &lt;gtk/gtk.h&gt;

int main( int   argc, char *argv[] )
{
	GtkWidget *window;
	GtkWidget *pMainWidget;
	GdkPixbuf *image;
	gboolean ret = 0;
	gtk_init (&amp;argc, &amp;argv);
printf(&quot;\n\n\ngtk_init (&amp;argc, &amp;argv);\n\n\n&quot;);		
	window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
	
	//gtk_container_set_border_width (GTK_CONTAINER (window), 10);
	
	image  = gdk_pixbuf_new_from_file (&quot;test.gif&quot;, NULL);
   	if (!image)
		return FALSE;
   	pMainWidget = gtk_image_new_from_pixbuf(image);
printf(&quot;\n\n\npMainWidget = gtk_image_new_from_pixbuf(image);\n\n\n&quot;);	
	gtk_widget_show (pMainWidget);
	
	gtk_container_add (GTK_CONTAINER (window), pMainWidget);
 printf(&quot;\n\n\ngtk_container_add (GTK_CONTAINER (window), pMainWidget);\n\n\n&quot;) ; 
	gtk_widget_show (window);
printf(&quot;\n\n\nABHISHEK START OF gtk_main\n\n\n&quot;);	
	gtk_main ();
printf(&quot;\n\n\nABHISHEK END OF gtk_main\n\n\n&quot;);
	return 0;
}
</pre></div>
<div>Can anybody Plz throw some light on it?</div>
<div>Thanks in advcance<br>-- <br>Thanks &amp; Regards,<br>kaka </div>

------=_Part_5204_15501233.1197880265204--
