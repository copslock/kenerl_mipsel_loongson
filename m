Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 17:26:54 +0000 (GMT)
Received: from directfb.org ([212.227.87.76]:9458 "EHLO www.directfb.org")
	by ftp.linux-mips.org with ESMTP id S20030505AbXLQR0q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Dec 2007 17:26:46 +0000
Received: from shizo ([10.1.1.6])
	by www.directfb.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <dok@directfb.org>)
	id 1J4Jjf-0005vp-Km; Mon, 17 Dec 2007 18:26:35 +0100
Message-ID: <4766B149.5050109@directfb.org>
Date:	Mon, 17 Dec 2007 18:26:33 +0100
From:	Denis Oliver Kropp <dok@directfb.org>
User-Agent: Thunderbird 2.0.0.6 (X11/20070803)
MIME-Version: 1.0
To:	kaka <share.kt@gmail.com>
CC:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	celinux-dev@tree.celinuxforum.org,
	linux-fbdev-users@lists.sourceforge.net,
	directfb-users@directfb.org, directfb-dev@directfb.org
Subject: Re: [directfb-dev] Error in running gtk example on cross compiled
 GTK	with DirectFB on MIPS board
References: <eea8a9c90712170031i62e4ac4ak687a198200f59920@mail.gmail.com>
In-Reply-To: <eea8a9c90712170031i62e4ac4ak687a198200f59920@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dok@directfb.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dok@directfb.org
Precedence: bulk
X-list: linux-mips

kaka wrote:
> HI ALL,
> 
> We have successfully cross compiled GTK and DIRECTFB with all its
> dependencies for MIPS board.
> On running the basic test example of GTK, it is getting struck in the thread
> loop infinitely.
> We had put the  "debug printf"  statement in the gtkmain.c and debugged the
> test example.
> It is getting struck in the * g_main_loop_run (loop);* given below is
> the  code(code
> snippet from gtkmain.c)
> 
> void
> gtk_main (void)
> {
>   GList *tmp_list;
>   GList *functions;
>   GtkInitFunction *init;
>   GMainLoop *loop;
> printf("\n%s :: %d\n",__FILE__,__LINE__);
>   gtk_main_loop_level++;
> 
>   loop = g_main_loop_new (NULL, TRUE);
>   main_loops = g_slist_prepend (main_loops, loop);
> printf("\n%s :: %d\n",__FILE__,__LINE__);
>   tmp_list = functions = init_functions;
>   init_functions = NULL;
> 
>   while (tmp_list)
>     {
>       init = tmp_list->data;
>       tmp_list = tmp_list->next;
> 
>       (* init->function) (init->data);
>       g_free (init);
>     }
>   g_list_free (functions);
> printf("\n%s :: %d\n",__FILE__,__LINE__);
>   if (g_main_loop_is_running (main_loops->data))
>     {
>    * printf("\n%s :: %d\n",__FILE__,__LINE__);
>       GDK_THREADS_LEAVE ();
>       g_main_loop_run (loop);
>       GDK_THREADS_ENTER ();
> *      printf("\n%s :: %d\n",__FILE__,__LINE__);

That's normal. If you want runtime you have to create a timer or register idle or timeout functions.

> 	gtk_container_add (GTK_CONTAINER (window), pMainWidget);
>  printf("\n\n\ngtk_container_add (GTK_CONTAINER (window),
> pMainWidget);\n\n\n") ;
> 	gtk_widget_show (window);
> printf("\n\n\nABHISHEK START OF gtk_main\n\n\n");	
> 	gtk_main ();
> printf("\n\n\nABHISHEK END OF gtk_main\n\n\n");
> 	return 0;

Simply/weakly put: it should not return before the application is quit.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"
