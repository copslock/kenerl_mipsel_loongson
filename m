Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5D8RLnC024739
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 13 Jun 2002 01:27:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5D8RLlj024738
	for linux-mips-outgoing; Thu, 13 Jun 2002 01:27:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5D8RInC024735
	for <linux-mips@oss.sgi.com>; Thu, 13 Jun 2002 01:27:19 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id 614F08D40; Thu, 13 Jun 2002 10:29:49 +0200 (CEST)
Date: Thu, 13 Jun 2002 10:29:49 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Sam <iskoo@ms45.hinet.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: # ld.script syntax
Message-ID: <20020613102949.A21623@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Sam <iskoo@ms45.hinet.net>, linux-mips@oss.sgi.com
References: <004801c212b2$295c7900$780411ac@sam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004801c212b2$295c7900$780411ac@sam>; from iskoo@ms45.hinet.net on Thu, Jun 13, 2002 at 04:13:11PM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 13, 2002 at 04:13:11PM +0800, Sam wrote:
> Hi everybody,
> 
> I try to find the relation about the setup of ramdisk initrd
> >From the sample of Philp Nino, I found the ld.script.in on /arch/mips/
> But I do not understand the syntax of ld script,
> Does anybody tell me where to find the relevent document to understand the
> file,
"info ld". See section "Scripts".
Hope this helps,
 -- Guido
