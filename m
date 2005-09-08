Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2005 18:27:39 +0100 (BST)
Received: from 216-239-45-4.google.com ([IPv6:::ffff:216.239.45.4]:11195 "EHLO
	216-239-45-4.google.com") by linux-mips.org with ESMTP
	id <S8225304AbVIHR1W>; Thu, 8 Sep 2005 18:27:22 +0100
Received: from [172.29.52.41] (dank.smo.corp.google.com [172.29.52.41])
	by vegeta.corp.google.com with ESMTP id j88HXriU026558;
	Thu, 8 Sep 2005 10:33:53 -0700
Message-ID: <43207601.7020000@kegel.com>
Date:	Thu, 08 Sep 2005 10:33:53 -0700
From:	Daniel Kegel <dank@kegel.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	gcc@gcc.gnu.org, Jonathan Day <imipak@yahoo.com>
CC:	linux-mips@linux-mips.org, crossgcc <crossgcc@sources.redhat.com>
Subject: Re: Question regarding compiling a toolchain for a Broadcom SB1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dank@kegel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dank@kegel.com
Precedence: bulk
X-list: linux-mips

Jonathan Day <imipak at yahoo dot com> wrote:
> Crosstool, for example, only supports 32-bit MIPS -
> and even then the build matrix is a pretty shade of
> red for the most part.

[ The build matrix: http://kegel.com/crosstool/current/buildlogs/ ]

There are quite a few combinations that build for 32-bit mips with crosstool, e.g.
  mips-gcc-3.2.3-glibc-2.2.5
  mips-gcc-3.2.3-glibc-2.3.2
  mips-gcc-3.3.6-glibc-2.2.5
  mips-gcc-3.3.6-glibc-2.3.5
  mips-gcc-3.4.4-glibc-2.3.2-hdrs-2.6.11.2
  mips-gcc-3.4.4-glibc-2.3.5-hdrs-2.6.11.2
  mips-gcc-4.1-20050702-glibc-2.3.2-hdrs-2.6.11.2
  mips-gcc-4.1-20050709-glibc-2.3.2-hdrs-2.6.11.2
so the situation isn't that dire.

For the record, I would be more than happy to add mips64 support to crosstool.
http://www.linux-mips.org/archives/linux-mips/2005-07/msg00189.html
http://documents.jg555.com/cross-lfs/mips64-64/cross-tools/glibc.html
http://documents.jg555.com/cross-lfs/mips64-64/cross-tools/gcc-final.html
mentions some patches that might be needed.
I haven't had time to chase them down and add them to crosstool,
but if anybody else felt like it, I'd gladly accept the patches.
I'm sure a lot of mips64 users would be very happy.
- Dan
