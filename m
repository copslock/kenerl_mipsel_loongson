Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2002 09:34:20 +0200 (CEST)
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:48602 "EHLO
	rwcrmhc52.attbi.com") by linux-mips.org with ESMTP
	id <S1121744AbSI1HeT>; Sat, 28 Sep 2002 09:34:19 +0200
Received: from lucon.org ([12.234.88.146]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020928073412.MLIN1696.rwcrmhc52.attbi.com@lucon.org>;
          Sat, 28 Sep 2002 07:34:12 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id CA0592C593; Sat, 28 Sep 2002 00:34:11 -0700 (PDT)
Date: Sat, 28 Sep 2002 00:34:11 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Does swap on IDE HD work on malta/mipsel?
Message-ID: <20020928003411.A18015@lucon.org>
References: <20020927230307.A4100@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020927230307.A4100@lucon.org>; from hjl@lucon.org on Fri, Sep 27, 2002 at 11:03:07PM -0700
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 27, 2002 at 11:03:07PM -0700, H. J. Lu wrote:
> I compiled today's 2.4 kernel from CVS. Swap on IDE HD doesn't work. I
> got
> 
> # mkswap /dev/hda3
> Setting up swapspace version 1, size = 512060K
> # swapon /dev/hda3
> swapon: /dev/hda3: Invalid argument
> 
> and kernel reported
> 
> Unable to find swap-space signature
> 
> BTW, it used to work fine.
> 

After switching to 2.4.19 with

# cvs update -A -r linux_2_4_19 -dP

swap works fine.


H.J.
