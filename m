Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 12:16:29 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:13546 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122958AbSIEKQ2>;
	Thu, 5 Sep 2002 12:16:28 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g85AFkXb013457;
	Thu, 5 Sep 2002 03:15:46 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA10680;
	Thu, 5 Sep 2002 03:15:41 -0700 (PDT)
Received: from coplin19.mips.com (IDENT:root@coplin19 [192.168.205.89])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g85AFeb01541;
	Thu, 5 Sep 2002 12:15:40 +0200 (MEST)
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id g85AFeD04076;
	Thu, 5 Sep 2002 12:15:40 +0200
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Thu, 5 Sep 2002 12:15:40 +0200 (MEST)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Jun Sun <jsun@mvista.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	<linux-mips@linux-mips.org>
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020904204038.D1121@linux-mips.org>
Message-ID: <Pine.LNX.4.44.0209051143300.2960-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <kjelde@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kjelde@mips.com
Precedence: bulk
X-list: linux-mips

On Wed, 4 Sep 2002, Ralf Baechle wrote:

...
> Several approach to solve that problem.  Adding another 1000 entries - which
> will cost 8000 bytes of memory that will be mostly zeros.  Having wrappers
> for each function that do the appropriate argument and result convertion
> is another.  etc.

Ralf, that's not true. In our current 64-bit kernel we have 234 entries 
for N64 which uses 8*234 = 1872 bytes. N32 has 241 entries using 1928 
bytes. Even in an embedded environment that's not a lot of memory.


/Kjeld

-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
