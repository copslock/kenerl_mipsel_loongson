Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Dec 2007 19:11:05 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.226]:28483 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S28583905AbXLTTK4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Dec 2007 19:10:56 +0000
Received: by wr-out-0506.google.com with SMTP id 67so2717149wri.6
        for <linux-mips@linux-mips.org>; Thu, 20 Dec 2007 11:09:55 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=e/6DaMWAhwrgYqbRjZci70QLFPWAzjW3mZF1fcNOfOQ=;
        b=EGtxFUjQTu7L1h/rB3OpHFm8/qaLikdKpZfz0plmDQ0+gttxNLPjlhW5cVYMHv3RYCjbusuJN+qFPr7hKAxgZxoecm1Dav+uyQnvaJhlDPOLmb1EOEgTRgICBbr1u6ZpCrhfuvC7C3nKqpA/6kJjMLUW7K3qmkCWXgqlFJUaAi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mi2FHL9mbOU0bO5R46gTX8sI0OGcIEny43/uLe48xZfqm312x8R0ZIR2PJE/T0pslaK5u3ZRmZdfZaQLkd+DI3p27XF7gsE0rw3fovJqzia+JU+Qgxe3kEbk57t/mS7gObT4fJqQPTn5yR4adqvT4lPVRvsfgRzHYzyek0oqN/0=
Received: by 10.142.212.19 with SMTP id k19mr281805wfg.66.1198177794249;
        Thu, 20 Dec 2007 11:09:54 -0800 (PST)
Received: by 10.142.213.18 with HTTP; Thu, 20 Dec 2007 11:09:54 -0800 (PST)
Message-ID: <3e9035250712201109n341b972cl80256a0c8523b653@mail.gmail.com>
Date:	Thu, 20 Dec 2007 11:09:54 -0800
From:	"Mike Emmel" <mike.emmel@gmail.com>
To:	kaka <share.kt@gmail.com>
Subject: Re: [directfb-dev] Error in running gtk example on cross compiled GTK with DirectFB on MIPS board
Cc:	"Denis Oliver Kropp" <dok@directfb.org>, linux-mips@linux-mips.org,
	uclinux-dev@uclinux.org, linux-fbdev-users@lists.sourceforge.net,
	directfb-dev@directfb.org, celinux-dev@tree.celinuxforum.org,
	directfb-users@directfb.org
In-Reply-To: <eea8a9c90712201008n37a9a759j6dcee5ee067f918a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <eea8a9c90712170031i62e4ac4ak687a198200f59920@mail.gmail.com>
	 <4766B149.5050109@directfb.org>
	 <eea8a9c90712201008n37a9a759j6dcee5ee067f918a@mail.gmail.com>
Return-Path: <mike.emmel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mike.emmel@gmail.com
Precedence: bulk
X-list: linux-mips

I suspect this is related to the creation of a top level ARGB surface
when gtk is initialized.
You probably should dig around a bit but it looks to me like its a
issue with surface formats.
Since your doing the driver you should try and make sure that you get
a accelerated surface
working for Gtk/Cairo this would need to be either RGB/ARGB because of
limited pixel
format support in Cairo.

gdk_display_open in
gdkdisplay-directfb.c

See how it finally initializes and I suspect that if you do the same
in a simple DirectFB app you get the black screen
and can debug.

On Dec 20, 2007 10:08 AM, kaka <share.kt@gmail.com> wrote:
> Hi Denis,
>
> I am writing gfx driver for DirectFB on BroadCom chip.
> Right now i am using FBdev system to display graphics on BCM chip(MIPS
> platform)  which should use software fallbacks from DirectFB.Later on i 'll
> add hardware accelerartion also.
> My framebuffer driver for BCM chip is working fine. I have checked it by
> running a small example. Also the gfxdriver for directFB is working fine for
> Video and Image.
> The problem which i am facing right now is that i am running the fill
> rectangle example.
> IT is not filling any color in the rectangle. I am always getting the black
> screen.
>
> Could you plz provide some clue on it ?
> Also could you plz specify the file name and function in which directFB
> library is writing into the framebuffer memory the color pixel information?
>
> Thanks in Advance.
> kaka
>
>
>
> On 12/17/07, Denis Oliver Kropp <dok@directfb.org> wrote:
>
> > kaka wrote:
> > > HI ALL,
> > >
> > > We have successfully cross compiled GTK and DIRECTFB with all its
> > > dependencies for MIPS board.
> > > On running the basic test example of GTK, it is getting struck in the
> thread
> > > loop infinitely.
> > > We had put the  "debug printf"  statement in the gtkmain.c and debugged
> the
> > > test example.
> > > It is getting struck in the * g_main_loop_run (loop);* given below is
> > > the  code(code
> > > snippet from gtkmain.c)
> > >
> > > void
> > > gtk_main (void)
> > > {
> > >   GList *tmp_list;
> > >   GList *functions;
> > >   GtkInitFunction *init;
> > >   GMainLoop *loop;
> > > printf("\n%s :: %d\n",__FILE__,__LINE__);
> > >   gtk_main_loop_level++;
> > >
> > >   loop = g_main_loop_new (NULL, TRUE);
> > >   main_loops = g_slist_prepend (main_loops, loop);
> > > printf("\n%s :: %d\n",__FILE__,__LINE__);
> > >   tmp_list = functions = init_functions;
> > >   init_functions = NULL;
> > >
> > >   while (tmp_list)
> > >     {
> > >       init = tmp_list->data;
> > >       tmp_list = tmp_list->next;
> > >
> > >       (* init->function) (init->data);
> > >       g_free (init);
> > >     }
> > >   g_list_free (functions);
> > > printf("\n%s :: %d\n",__FILE__,__LINE__);
> > >   if (g_main_loop_is_running (main_loops->data))
> > >     {
> > >    * printf("\n%s :: %d\n",__FILE__,__LINE__);
> > >       GDK_THREADS_LEAVE ();
> > >       g_main_loop_run (loop);
> > >       GDK_THREADS_ENTER ();
> > > *      printf("\n%s :: %d\n",__FILE__,__LINE__);
> >
> > That's normal. If you want runtime you have to create a timer or register
> idle or timeout functions.
> >
> > >       gtk_container_add (GTK_CONTAINER (window), pMainWidget);
> > >  printf("\n\n\ngtk_container_add (GTK_CONTAINER (window),
> > > pMainWidget);\n\n\n") ;
> > >       gtk_widget_show (window);
> > > printf("\n\n\nABHISHEK START OF gtk_main\n\n\n");
> > >       gtk_main ();
> > > printf("\n\n\nABHISHEK END OF gtk_main\n\n\n");
> > >       return 0;
> >
> > Simply/weakly put: it should not return before the application is quit.
> >
> > --
> > Best regards,
> > Denis Oliver Kropp
> >
> > .------------------------------------------.
> > | DirectFB - Hardware accelerated graphics |
> > | http://www.directfb.org/                 |
> > "------------------------------------------"
> >
>
>
>
> --
> Thanks & Regards,
> kaka
> _______________________________________________
> directfb-dev mailing list
> directfb-dev@directfb.org
> http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-dev
>
>
