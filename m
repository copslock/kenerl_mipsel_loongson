Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Sep 2010 10:59:58 +0200 (CEST)
Received: from notav8.com ([66.160.168.115]:57473 "HELO notav8.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1491023Ab0IAI7y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Sep 2010 10:59:54 +0200
Received: from www.notav8.com ([66.160.168.115]) by notav8.com for <linux-mips@linux-mips.org>; Wed, 1 Sep 2010 01:59:44 -0700
Received: from 98.248.135.54
        (SquirrelMail authenticated user chris)
        by www.notav8.com with HTTP;
        Wed, 1 Sep 2010 01:59:44 -0700 (PDT)
Message-ID: <1341.98.248.135.54.1283331584.squirrel@www.notav8.com>
Date:   Wed, 1 Sep 2010 01:59:44 -0700 (PDT)
Subject: Network Inst
From:   chris@notav8.com
To:     linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.5.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-archive-position: 27707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@notav8.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 277

I've been trying to do a network install of Debian on an SGI Indigo2
without success.  Using tcpdump I can see the BOOTP request go out and the
reply come back.  I don't think the reply is being fragmented.  The SGI is
responding to ARP requests so I know it's receiving.  I'd like to compare
my BOOTP response with a known working one.  Can someone send me a trace
of a successful BOOTP transaction?

Thanks,


Chris Rhodin
