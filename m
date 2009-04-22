Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2009 10:08:32 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:32208 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20021320AbZDVJIW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2009 10:08:22 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LwYRB-00071t-Ul
	for linux-mips@linux-mips.org; Wed, 22 Apr 2009 02:08:13 -0700
Message-ID: <23172497.post@talk.nabble.com>
Date:	Wed, 22 Apr 2009 02:08:13 -0700 (PDT)
From:	fredtan <tanflying@gmail.com>
To:	linux-mips@linux-mips.org
Subject: how to clear the D_cache and I_cache in the MIPS linux ?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Nabble-From: tanflying@gmail.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanflying@gmail.com
Precedence: bulk
X-list: linux-mips


      I am porting native‐code compilation to a JavaScript engine in the MIPS
platform.After the program 

finished dynamic and transparent binary translation，it first write back the
code into the memory from 

D_CACHE,then invalidate I_CACHE,then run the code. My MIPS does not have
SYNCI instruction,Cache 

instruction is a privilege instruction, the program has no right to use it.
So , What can I do ?

Very grateful for any reply !!!
-- 
View this message in context: http://www.nabble.com/how-to-clear-the-D_cache-and-I_cache-in-the-MIPS-linux---tp23172497p23172497.html
Sent from the linux-mips main mailing list archive at Nabble.com.
