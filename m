Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8CGrhm13532
	for linux-mips-outgoing; Wed, 12 Sep 2001 09:53:43 -0700
Received: from mail.aeptec.com (mail.aeptec.com [12.38.17.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8CGrfe13528
	for <linux-mips@oss.sgi.com>; Wed, 12 Sep 2001 09:53:41 -0700
Received: by MAIL with Internet Mail Service (5.5.2653.19)
	id <RY2D6M65>; Wed, 12 Sep 2001 12:53:40 -0400
Message-ID: <32CC5B62AF0BD2119E4C00A0C9663E226F8E2A@MAIL>
From: "Sun, Lei" <lsun@3eti.com>
To: "'H . J . Lu'" <hjl@lucon.org>, "Sun, Lei" <lsun@3eti.com>
Cc: "'Zhang Fuxin'" <fxzhang@ict.ac.cn>, linux-mips@oss.sgi.com
Subject: RE: RE: _gp_disp
Date: Wed, 12 Sep 2001 12:53:39 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The source I am building is not a kernel module, I built kernel module with
no problem.

-----Original Message-----
From: H . J . Lu [mailto:hjl@lucon.org]
Sent: Wednesday, September 12, 2001 12:50 PM
To: Sun, Lei
Cc: 'Zhang Fuxin'; linux-mips@oss.sgi.com
Subject: Re: RE: _gp_disp


On Wed, Sep 12, 2001 at 12:48:57PM -0400, Sun, Lei wrote:
> Hi:
>   Unfortunately, make clean didn't work, the linking problem still sit
> there!
> 

Please check the kernel source how to build the mips kernel modules.

# make modules

should give you a clue.


H.J.
