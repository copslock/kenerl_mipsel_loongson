Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3HHD3X17278
	for linux-mips-outgoing; Tue, 17 Apr 2001 10:13:03 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3HHCbM17219;
	Tue, 17 Apr 2001 10:12:39 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3HHC5Z07678;
	Tue, 17 Apr 2001 14:12:05 -0300
Date: Tue, 17 Apr 2001 14:12:05 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Quinn Jensen <jensenq@Lineo.COM>
Cc: linux-mips@oss.sgi.com, Kanoj Sarcar <kanoj@oss.sgi.com>,
   linux-origin@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20010417141205.E7177@bacchus.dhis.org>
References: <200104111800.LAA23131@google.engr.sgi.com> <3ADB2F50.80904@Lineo.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ADB2F50.80904@Lineo.COM>; from jensenq@Lineo.COM on Mon, Apr 16, 2001 at 11:43:44AM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 16, 2001 at 11:43:44AM -0600, Quinn Jensen wrote:

> > receive_chars() was updated to look at ignore_mask ... if CREAD is not
> > set, around the time of opening via ioctls etc, it will not take inputs.
> > I haven't figured the details out, but I believe it is more of a *getty
> > config issue than anything else. 

> Same thing happens when I bring up 2.4.3 straight
> to a shell w/out any getty, as well.

Known problem on other architectures also.

  Ralf
