Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 19:52:27 +0000 (GMT)
Received: from 67-121-164-6.ded.pacbell.net ([IPv6:::ffff:67.121.164.6]:9863
	"EHLO mailserver.sunrisetelecom.com") by linux-mips.org with ESMTP
	id <S8225247AbULGTwW>; Tue, 7 Dec 2004 19:52:22 +0000
Received: from there ([192.168.50.222]) by mailserver.sunrisetelecom.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 7 Dec 2004 11:52:11 -0800
Content-Type: text/plain;
  charset="iso-8859-1"
From: Karl Lessard <klessard@sunrisetelecom.com>
To: =?iso-8859-1?q?J=F8rg=20Ulrich=20Hansen?= <jh@hansen-telecom.dk>
Subject: Re: au1100fb.c
Date: Tue, 7 Dec 2004 14:49:37 -0500
X-Mailer: KMail [version 1.3.2]
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAb4ajDk58bkCNi0V1ZTQFHIKAAAAQAAAAqiO8dTCmGkSJ6ESla6aONAEAAAAA@hansen-telecom.dk>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAb4ajDk58bkCNi0V1ZTQFHIKAAAAQAAAAqiO8dTCmGkSJ6ESla6aONAEAAAAA@hansen-telecom.dk>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <MAILSERVEREI2rV4Zne000005cb@mailserver.sunrisetelecom.com>
X-OriginalArrivalTime: 07 Dec 2004 19:52:11.0437 (UTC) FILETIME=[3DDDD5D0:01C4DC96]
Return-Path: <klessard@sunrisetelecom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: klessard@sunrisetelecom.com
Precedence: bulk
X-list: linux-mips

On December 7, 2004 03:38 am, you wrote:
> Hi Karl
>
> Thanks for the software. I have now added my tft and mono display to the
> driver.
> It works fine with a few changes.
> For the mono no memory was allocated for the framebuffer because the
> calculation gave 0 bytes:
> 	fbdev->fb_len = fbdev->panel->max_xres * fbdev->panel->max_yres *
> 		  	(fbdev->panel->max_bpp >> 3) *
> AU1100FB_NBR_VIDEO_BUFFERS;

You're right. As I told you, the driver needs to be tested in many 
configuration and for many boards, I have only done simple tests. Thanks for 
your notice!

> It also seems that for the tft to much is allocated.
> I have to look more into that.
> What is AU1100FB_NBR_VIDEO_BUFFERS used for?

It is because in our case (at sunrise), we use back buffers and want  to 
retrieve it by an offset from the front buffer. In the repository, 
AU1100FB_NBR_VIDEO_BUFFERS should be set to 1 (sorry if I forgot to change it 
in the patch), but it allows programmers to allocate one, two, or more back 
buffers by incrementing it.

> For mono the tux logo does not come up, and if I disable the logo then the
> framebuffer will not be initialized.
> Do I then have to do something manually?

The mono logo works well for me though. The driver turns up the monitor at 
bootup only in two cases for now: you are using the framebuffer console, or 
you don't use the fb console but still want the logo to show up.

> I have added au1100fb_ioctl so I can control the contrast/pwm for my mono
> display.
> I also had to change the clock settings. My board came up with a different
> clock rate.
>
> It looks good I think It should be added to the repository. Not just
> because of the small tests I have made but because it is there and it works
> better than what is already there.
> Is it Pete Popov that has to add it?

Pete just send me a mail saying that he is about to test the code and submit 
it.

Thanks,
Karl

>
> Kind regards Jorg
>
> --------------<<<<<<<<<OOOOOOOO>>>>>>>>>--------------
> Jorg Hansen               email: jh@hansen-telecom.dk
> Hansen Telecom            Tel: +45 7342 0220
> Ellegaardvej 36           Fax: +45 7342 0221
> 6400 Sonderborg           Mob: +45 2819 1969
> Denmark                   http://www.hansen-telecom.dk
>
> Modules for rapid design of mechatronic products
>        http://www.mechatronicbrick.dk
> --------------<<<<<<<<<OOOOOOOO>>>>>>>>>--------------
>
>
> -----Original Message-----
> From: Karl Lessard (by way of Karl Lessard <klessard@sunrisetelecom.com>)
> [mailto:klessard@sunrisetelecom.com]
> Sent: 2. december 2004 16:44
> To: Jørg Ulrich Hansen
> Cc: linux-mips@linux-mips.org
> Subject: Re: au1100fb.c
>
>
> Hi Jørg,
>
> I've modified it a little bit since I've post it on the list, so here's the
> .c/.h files I use now, and a patch that should also apply. This should work
> with current linux-mips cvs (actually it do on a 22/11/04 snapshot).
>
> I've never tested it on other boards that the pb1100 though. Also, I use
> the same scheme as in Linux 2.4, i.e. panels supported are declared in
> au1100fb.h.
>
> I hope this will work for you, and don't hesitate to interrupt me if you
> have any questions/problems. We personnally decided to work with a
> different
>
> graphic chip, so I probably don't need your version of the driver but
> thanks
>
> for offering it!
>
> Regards,
> Karl
>
>
>
> Jørg Ulrich Hansen wrote:
>
> Hi Karl
>
> Sorry to disturb you, but I can see that you have a framebuffer for au1100
> for Linux 2.6. I have also done the same work but I have some problems with
> nano-X that I belive is the framebuffers fault.
>
> Your patch that I found on the list I am having problems with to apply.
>
> Do you mind to send me your version of the framebuffer either directly or
> to the list.
>
> If you are interrested you can have my version of au1100fb.c/h as well.
>
> Kind regards Jorg
>
> --------------<<<<<<<<<OOOOOOOO>>>>>>>>>--------------
> Jorg Hansen               email: jh@hansen-telecom.dk
> Hansen Telecom            Tel: +45 7342 0220
> Ellegaardvej 36           Fax: +45 7342 0221
> 6400 Sonderborg           Mob: +45 2819 1969
> Denmark                   http://www.hansen-telecom.dk
>
> Modules for rapid design of mechatronic products
>        http://www.mechatronicbrick.dk
> --------------<<<<<<<<<OOOOOOOO>>>>>>>>>--------------
