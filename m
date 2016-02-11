Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 15:25:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31338 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012528AbcBKOZunrpLv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 15:25:50 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 9652F6A19AB24;
        Thu, 11 Feb 2016 14:25:42 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 11 Feb 2016
 14:25:44 +0000
Date:   Thu, 11 Feb 2016 14:25:43 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Marek <mmarek@suse.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-kbuild@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ld-version: Drop the 4th and 5th version components
Message-ID: <alpine.DEB.2.00.1602111359390.15885@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

... making upstream development binutils snapshots work as expected,
e.g.:

$ mips64el-linux-ld --version
GNU ld (GNU Binutils) 2.20.1.20100303
[...]
$ 

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
 It may well actually have been a release mistake with the proper 2.20.1 
maintenance release as I reckon the development vs release build switch is 
a knob that used to require to be flipped in the sources by the release 
manager; maybe it still does.  Either way this version guarantees all the 
2.20.1 stuff to be present as the version number is only bumped up as a 
release is being made, so any prior snapshot would report 2.20.0.20100302, 
etc., or maybe even 2.20.0.20100303 if made earlier on on the same day.

 So please apply, or anyone is welcome to improve it, as my limited awk-fu 
(which I'll be happy to get corrected) tells me the script doesn't really 
terminate parsing on a non-point-non-digit character.

 NB comments in scripts/Kbuild.include around `ld-version' have not been 
accordingly updated in the course of changes made to `ld-version.sh' and 
they still need such an update, unless we right-shift the version code 
calculated back by 4 decimal digits, which I hesitated doing here for 
simplicity.  What was the original reason to add the 4th and 5th 
components?

  Maciej

linux-mips-ld-version-fix.diff
Index: linux-20160211/scripts/ld-version.sh
===================================================================
--- linux-20160211.orig/scripts/ld-version.sh
+++ linux-20160211/scripts/ld-version.sh
@@ -5,6 +5,6 @@
 	gsub(".*version ", "");
 	gsub("-.*", "");
 	split($1,a, ".");
-	print a[1]*100000000 + a[2]*1000000 + a[3]*10000 + a[4]*100 + a[5];
+	print a[1]*100000000 + a[2]*1000000 + a[3]*10000;
 	exit
 	}
