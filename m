Received:  by oss.sgi.com id <S554169AbRBAUfG>;
	Thu, 1 Feb 2001 12:35:06 -0800
Received: from stereotomy.lineo.com ([64.50.107.151]:37394 "HELO
        stereotomy.lineo.com") by oss.sgi.com with SMTP id <S554162AbRBAUew>;
	Thu, 1 Feb 2001 12:34:52 -0800
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP id E42694CB82
	for <linux-mips@oss.sgi.com>; Thu,  1 Feb 2001 13:34:49 -0700 (MST)
Message-ID: <3A79C869.2040001@Lineo.COM>
Date:   Thu, 01 Feb 2001 13:34:49 -0700
From:   Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: NFS root with cache on
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Is anyone else having trouble with NFS root on
the 2.4.0 kernel?  It won't come up with the
KSEG0 cache on unless I pepper the network driver
with flush calls.

I'm using the new mips32 mm and cache code with
my own patches to deal with the IDT 334's weird
way bit (it's clear up at bit 12 even though the
cache is only 2k).

Quinn
