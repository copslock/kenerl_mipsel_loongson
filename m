Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBVECfk03458
	for linux-mips-outgoing; Mon, 31 Dec 2001 06:12:41 -0800
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBVECYg03452
	for <linux-mips@oss.sgi.com>; Mon, 31 Dec 2001 06:12:34 -0800
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 1ADF41E731; Mon, 31 Dec 2001 14:12:27 +0100 (MET)
X-Authentication-Warning: sykes.suse.de: schwab set sender to schwab@suse.de using -f
To: Lennert Buytenhek <buytenh@gnu.org>
Cc: rth@dot.cygnus.com, linux-arm-kernel@lists.arm.linux.org.uk,
   dev-etrax@axis.com, linux-ia64@linuxia64.org,
   linux-m68k@lists.linux-m68k.org, linux-mips@oss.sgi.com,
   grundler@cup.hp.com, cort@fsmlabs.com, linux-390@vm.marist.edu,
   gniibe@mri.co.jp, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
   jdike@karaya.com
Subject: Re: [Linux-ia64] [PATCH][RFC][CFT] remove global errno from the kernel, make _syscallX kernel-only
References: <20011230220500.A10224@gnu.org>
X-Yow: YOW!!
From: Andreas Schwab <schwab@suse.de>
Date: 31 Dec 2001 14:11:31 +0100
In-Reply-To: <20011230220500.A10224@gnu.org> (Lennert Buytenhek's message of "Sun, 30 Dec 2001 22:05:00 -0500")
Message-ID: <je3d1ra60s.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id fBVECZg03453
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Lennert Buytenhek <buytenh@gnu.org> writes:

|> What I would like to know from each architecture team:
|> - What is your arch's policy on userspace usage of asm/unistd.h, and
|>   consequently, what is your opinion on the goal these patches
|>   aim for?

I very much appreciate the removal of the _syscallX macros.  FWIW, the
ia64 version of these macros never worked in userspace anyway.

|> - Are the changes I made in [1] and [2] for your $arch technically
|>   correct?

The m68k changes look ok.

|> Please CC me on replies as I'm not on any of the lists posted to.
|> 
|> My intention is to push these to Linus for 2.5 if everyone agrees.
|> They're probably too intrusive for 2.4 (although I'd love people
|> to convince me otherwise).

I wouldn't mind putting it into 2.4.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
