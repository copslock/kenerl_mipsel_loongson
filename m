Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 08:36:56 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:60109 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23828773AbYKVIgp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Nov 2008 08:36:45 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4927c48e0000>; Sat, 22 Nov 2008 03:36:30 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 22 Nov 2008 00:31:16 -0800
Received: from [192.168.111.195] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 22 Nov 2008 00:31:15 -0800
Message-ID: <4927C34F.4000201@caviumnetworks.com>
Date:	Sat, 22 Nov 2008 00:31:11 -0800
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.17) Gecko/20080829 Iceape/1.1.12 (Debian-1.1.12-1)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Is there no way to shared code with Linux and other OSes?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2008 08:31:15.0953 (UTC) FILETIME=[AF6C3610:01C94C7C]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Watching the discussion about Octeon patches submitted by Cavium
Networks, it seems apparent the majority of the problems simply come
from the fact that the code was written to be shared between multiple
operating systems. Code for programming the low level details of
hardware doesn't really change if the OS is Linux, VxWorks, BSD, or
something else. I've found it very depressing that most of the comments
basically come down to "this doesn't match the kernel coding standard,
change it". Obviously rewriting code for every coding standard and OS is
just a bug farm. Fixes will never get merged into all the rewrites.

Cavium can't be the first to want to share code. We'd like Octeon to be
well supported in the Linux kernel, but we'd also like other OSes to
work well too. There has to be some sort of middle ground here. Our base
"library" that is completely OS agnostic is actually license under the
BSD license to allow maximum portability between various OSes. What have
other people done before?

Through the discussion on the Octeon patches a number of bugs have been
uncovered and code has been improved. This part of the kernel submit
process is truly great. It just bothers me that so much needs to be
rewritten for arbitrary reasons.

For example, there has been lots of complaints that we use typedefs
throughout our code. Some people may not like them, but they have been
useful in the past. Some code used to use structures to reference chip
registers. Later due to new features, we found it necessary to change
the struct to a union with anonymous members. Because of the typedefs we
were able to change the fields for the new features without breaking
compatibility with existing code. If we'd used "struct" everywhere
instead of a typedef, all existing code would have to change for no
other reason except to substitute "union" for "struct". Not everyone has
 the freedom of the kernel programmers to ignore code outside of the
project.

So far the code submitted for Octeon is fairly trivial. The idea of
duplicating all of the network setup code for RGMII, GMII, MII, SGMII,
1000 base X, PICMG, XAUI, Higig, Higig2, etc is just plain scary. I'm
sure I forgot a few in this list. There has to be a better way.

Chad
