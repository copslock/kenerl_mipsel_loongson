Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2007 16:51:06 +0000 (GMT)
Received: from mx1.wp.pl ([212.77.101.5]:30434 "EHLO mx1.wp.pl")
	by ftp.linux-mips.org with ESMTP id S20038742AbXAaQvB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 Jan 2007 16:51:01 +0000
Received: (wp-smtpd smtp.wp.pl 7604 invoked from network); 31 Jan 2007 17:49:50 +0100
Received: from apn-236-153.gprsbal.plusgsm.pl (HELO [87.251.236.153]) (laurentp@[87.251.236.153])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-mips@linux-mips.org>; 31 Jan 2007 17:49:50 +0100
Message-ID: <45C0C956.2050009@wp.pl>
Date:	Wed, 31 Jan 2007 17:52:38 +0100
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Advice needed.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000                                      
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

Hello,
currently i am "fighting" with Edimax BR-6024Wg, (Realtek-8186 based,
lexra-mips). I need an advice from a system developer/programmer:

1). When using original firmware (EDIMAX-developed Linux-mips), task of
upgrading firmware is done by web server binary: webs, which is GoAhead
2.1.1, BUT Edimax didn't published "applets" -> C functions, that
implement real functionality.

2). In /dev directory there is a block node with mtd name. I have cat'ed
it's contents to /web, and downloaded to PC. File seems to be raw
contents of Flash memory: 2048*1024bytes long. If I drop first 64kB and
truncate file to same length that Edimax-supplied firmware, files show
to be the same (using cmp). The first 64kB looks to contain among
others, variables used in BR system. There is originally an utility
"flash" to get/set variables.

Now the question:
When I will have a new firmware (image) will it be safe(!?) to do such
thing: (instead of using webs binary):
cat /dev/mtd > some.file
dd first 64k of some.file to other.file,
then download image (from PC) to a third.file
cat other.file third.file > /dev/mtd back.??????

W.Piotrzkowski
