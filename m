Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 20:27:32 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:28937 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225421AbUANU1b>;
	Wed, 14 Jan 2004 20:27:31 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id i0EK5jl23882;
	Wed, 14 Jan 2004 15:05:45 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i0EKRCM29418;
	Wed, 14 Jan 2004 15:27:12 -0500
Received: from [192.168.123.101] (vpn50-25.rdu.redhat.com [172.16.50.25])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i0EKRAO22982;
	Wed, 14 Jan 2004 12:27:10 -0800
Subject: Re: Correct assembler/compiler options for 4KC core?
From: Eric Christopher <echristo@redhat.com>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	"Zajerko-McKee, Nick" <nmckee@telogy.com>,
	linux-mips@linux-mips.org
In-Reply-To: <Pine.GSO.4.44.0401141200460.13057-100000@ares.mmc.atmel.com>
References: <Pine.GSO.4.44.0401141200460.13057-100000@ares.mmc.atmel.com>
Content-Type: text/plain
Message-Id: <1074111949.6191.2.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 14 Jan 2004 12:25:49 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

On Wed, 2004-01-14 at 09:07, David Kesselring wrote:
> If 2.95 is too old for him, where should he(and I) get the latest stable
> packages. It seems like the MIPS environment is varied and there are
> toolchains for various processors in different locations. Is the toolchain
> and binutils for 4k/5k processors on the linux-mips.org ftp site?
> Is the correct gcc 3.2.xx? Will it build 2.4.2x that is in linux-mips cvs?
> Will it build 2.6? Will it build 64bit kernels? It would be nice if
> someone in the know could create a chart or add the info to readme or
> howto on linux-mips.org site.

A few answers:

a) -march=4kc for mainline gcc. there's an old dfa description for that
processor (not in the codebase, but I can be convinced to make it
available - I'm not as happy with it as with others) and hey, if the
option exists might as well use it.

b) IMO gcc.gnu.org for the gcc sources. sources.redhat.com for the
binutils sources. these will build 64bit kernels afaik. i've only tested
on an sb1250 and that is using the kernel sources from broadcom.

-eric

-- 
Eric Christopher <echristo@redhat.com>
