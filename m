Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2005 16:43:03 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.204]:35424 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8225474AbVFXPmq> convert rfc822-to-8bit;
	Fri, 24 Jun 2005 16:42:46 +0100
Received: by zproxy.gmail.com with SMTP id 13so191164nzp
        for <linux-mips@linux-mips.org>; Fri, 24 Jun 2005 08:41:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iWU2KgEztMWE3O5zi89zJ7GW74ThQhn7JVdX+PbQi7yJQxA0+tZXGT48h9qTjY/Gc20oHABOI9tQnVezTUyN85ZQxhJ1yFQbPu1rg5YBfoueSsuIHc+TmjUqzZH1A1eY5JGH5O7wGudlHSX8qN4WbNE7O7OuShc9p5hM5ysm4QI=
Received: by 10.36.222.5 with SMTP id u5mr1092076nzg;
        Fri, 24 Jun 2005 08:41:48 -0700 (PDT)
Received: by 10.36.68.6 with HTTP; Fri, 24 Jun 2005 08:41:48 -0700 (PDT)
Message-ID: <6097c4905062408414be88eb5@mail.gmail.com>
Date:	Fri, 24 Jun 2005 19:41:48 +0400
From:	Maxim Osipov <maxim.osipov@gmail.com>
Reply-To: maxim@mox.ru
To:	linux-mips@linux-mips.org
Subject: Fwd: mips64 gdb problem
In-Reply-To: <20050624141030.GB16942@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <6097c490506240642317a9836@mail.gmail.com>
	 <20050624141030.GB16942@nevyn.them.org>
Return-Path: <maxim.osipov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim.osipov@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

I wonder, is there some way to get debuger working on N64 target?

Thanks,
Maxim

---------- Forwarded message ----------
From: Daniel Jacobowitz <drow@false.org>
Date: Jun 24, 2005 6:10 PM
Subject: Re: mips64 gdb problem
To: maxim@mox.ru
Cc: gdb@sources.redhat.com


On Fri, Jun 24, 2005 at 05:42:25PM +0400, Maxim Osipov wrote:
> Hello,
>
> I have a problem trying to debug 64-bit mips binary with gdb-6.3. It
> fails with the following message:
>
> /home # gdb 64test
> GNU gdb 6.3
> Copyright 2004 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "mips64-linux-gnu"...
> ../../gdb-6.3/gdb/dwarf2-frame.c:1411: internal-error:
> decode_frame_entry_1: Assertion `fde->cie != NULL' failed.
> A problem internal to GDB has been detected,
> further debugging may prove unreliable.
> Quit this debugging session? (y or n)

GCC generates a wacky 64-bit format, otherwise only used on IRIX.  I
think this is a bug in GCC.  GDB could be adapted to generally sort of
cope with it, but not completely - there's some ambiguity.

--
Daniel Jacobowitz
CodeSourcery, LLC
