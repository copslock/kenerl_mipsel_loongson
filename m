Received:  by oss.sgi.com id <S553825AbRAKUhX>;
	Thu, 11 Jan 2001 12:37:23 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:29938 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553687AbRAKUhI>; Thu, 11 Jan 2001 12:37:08 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S867046AbRAKUZv>; Thu, 11 Jan 2001 18:25:51 -0200
Date:	Thu, 11 Jan 2001 18:25:50 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Michael Shmulevich <michaels@jungo.com>
Cc:	busybox@opensource.lineo.com,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: [BusyBox] 0.48 - Can't mount /proc
Message-ID: <20010111182550.A894@bacchus.dhis.org>
References: <3A5CAC53.60700@jungo.com> <20010110122159.A24714@lineo.com> <3A5D609C.2080201@jungo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5D609C.2080201@jungo.com>; from michaels@jungo.com on Thu, Jan 11, 2001 at 09:28:28AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jan 11, 2001 at 09:28:28AM +0200, Michael Shmulevich wrote:

> bash# mount proc /proc -t proc                                          
>        
> mount: Mounting proc on /proc failed: Unknown error 716878944           

716878944 is 0x2abab460, a typical address of a shared library or malloced
memory allocated via mmap(2).

  Ralf
