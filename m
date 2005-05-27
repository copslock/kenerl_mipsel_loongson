Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2005 17:28:42 +0100 (BST)
Received: from server256.com ([IPv6:::ffff:202.85.141.143]:6080 "HELO
	server256.com") by linux-mips.org with SMTP id <S8226068AbVE0Q2Z>;
	Fri, 27 May 2005 17:28:25 +0100
Received: (qmail 28556 invoked by uid 512); 27 May 2005 16:28:16 -0000
Message-ID: <20050527162816.31998.qmail@server256.com>
Reply-To: "Cameron Cooper" <developer@phatlinux.com>
From:	"Cameron Cooper" <developer@phatlinux.com>
To:	linux-mips@linux-mips.org
Subject: Re: Porting To New System
Date:	Fri, 27 May 2005 16:28:16 +0000
MIME-Version: 1.0
X-Mailer: WebMail 2.0
X-Originating-IP: 128.146.88.154
X-Originating-Email: developer@phatlinux.com
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-Path: <developer@phatlinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: developer@phatlinux.com
Precedence: bulk
X-list: linux-mips

>  > You should probably have a look at http://www.psp-linux.org/ click on
>  > messages boards at the top of the page to get to all the action.  I am
>  > sure these guys can answer all your questions.
>  
>  Hurm, hurm. I think that the closed-circle development model is, uhm, less
>  efficient - there are no tech info on the forums which means nobody can
>  try and follow. They just finished organizing themselves, and it took them
>  *three months*. Three months wasted on choosing developers. He he he.

That project is pretty much a joke. There is literally no work being done there. After three months of selecting developers they chose 12 people, and of those twelve were me and an application someone submitted under the name Dennis Ritchie. Since they have chosen developers over a month ago, they have not done a single thing. Beyond that, I don't like their closed development model. I have started a Sourceforge project for PSP Linux at psplinux.sf.net .
  
>  That said, they have really hard work to do - I wish them all the luck
>  they need, which is *a lot*. Cracking locked-down systems with proprietary
>  formats is incredibly hard. It's hard enough when they aren't proprietary,
>  or when they aren't deliberately locked-down.

I understand that cracking a closed system is very hard, so I would rather not do it that way. I have never ported a kernel, so I don't know what I will suggest is possable, but it seems like it could be. 

At this time I can write code for the PSP. I have access to the keypad, MemoryStick, and the frame buffer. The programs that I compile can be placed on the memory stick and launched from the PSP's OS. All I/O in the program is done through calls to libraries provided in the firmware, which are part of the PSPs OS. Becuase the PSP makes heavy use of encryption, it has been very hard to reverse engineer the software. We can't simply look at the libraries to understand the hardware better, because they are encrypted. They only way we have been able to discover anything about the libraries is through the small bits of uencrypted code that were extracted from the firmware chip.

What I would like to know is if it would be possable to do what User Mode Linux has done. Would it be possable to run Linux on top of the PSP's current OS, and write drivers for Linux which will use the libraries provided by the firmware? I know that this is not an ideal solution, but when the PSP being as closed as it as, I see it being a very long time until we will know enough about the hardware to do it another way. Mostly because the PSP makes much use of many custom chips and almost every executable is encrypted.

So even if this is a bad way of doing it, is it even possable?

Thanks,
Cameron Cooper
