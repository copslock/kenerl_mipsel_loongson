Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Feb 2013 17:05:13 +0100 (CET)
Received: from keetweej.vanheusden.com ([80.101.105.103]:41972 "EHLO
        keetweej.vanheusden.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827497Ab3BFQFM2LcFe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Feb 2013 17:05:12 +0100
Received: from belle.intranet.vanheusden.com (unknown [192.168.64.100])
        by keetweej.vanheusden.com (Postfix) with ESMTP id 629CC15FB05
        for <linux-mips@linux-mips.org>; Wed,  6 Feb 2013 17:05:11 +0100 (CET)
Received: by belle.intranet.vanheusden.com (Postfix, from userid 1000)
        id 141E4945E7; Wed,  6 Feb 2013 17:05:10 +0100 (CET)
Date:   Wed, 6 Feb 2013 17:05:10 +0100
From:   folkert <folkert@vanheusden.com>
To:     linux-mips@linux-mips.org
Subject: prom start
Message-ID: <20130206160508.GR2118@belle.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL:  http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key:  http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sat Feb  2 10:16:14 CET 2013
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: folkert@vanheusden.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

Is this mailing list also meant for generic mips questions? (if not: any
suggestions for one that is?)

If so: I'mm experimenting a bit with mips, specifically on SGI hardware
(Indigo). Now it seems all mips systems have the prom at 0xbfc00000. But
how does it start? The first 0x3c0 bytes seem to be nonsense. Somewhere
on the web I found that 0xbfc00884 is the starting point but after
single stepping 5 instructions, the program counter jumps to 0x00000000
so I don't think that's the right one either. Also, reading the first 4
bytes from bfc00000 and using that as a pointer seems to be invalid too:
0bf000f0.
Anyone with insights regarding the booting of the prom on sgi systems?


Regards,

Folkert van Heusden
