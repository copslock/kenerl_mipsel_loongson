Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 02:42:33 +0000 (GMT)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:37554
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8225338AbVBWCmT>;
	Wed, 23 Feb 2005 02:42:19 +0000
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN jim, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Tue, 22 Feb 2005 18:42:17 -0800
  id 00008476.421BED89.00001DD2
Message-ID: <421BED79.2010305@jg555.com>
Date:	Tue, 22 Feb 2005 18:42:01 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Building GLIBC 2.3.4 on MIPS
References: <421BCF34.90308@jg555.com> <421BD616.4030101@avtrex.com>
In-Reply-To: <421BD616.4030101@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Thanx Kumba and David I really appreciate the help.

Got one other question for you, this was brought up on my LFS for the RaQ2.

http://sources.redhat.com/ml/libc-alpha/2005-01/msg00063.html

Here is the message for those who don't want to link.

A user attempting to build glibc kept getting "getconf" missing errors, 
upon checking /usr/bin/getconf, he found the getconf was a directory 
with 2 files in it

POSIX_V6_ILP32_OFFBIG
POSIX_V6_ILP32_OFF32

Now, I've been able to recreate this issue, but haven't figured out the 
root cause.
