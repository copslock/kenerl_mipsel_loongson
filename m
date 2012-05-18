Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 May 2012 20:06:39 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:37263 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901351Ab2ERSGg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 May 2012 20:06:36 +0200
Message-ID: <4FB68FA2.1030404@phrozen.org>
Date:   Fri, 18 May 2012 20:06:26 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dczhu@mips.com>
CC:     linux-mips@linux-mips.org, kevink@paralogos.com
Subject: Re: [PATCH v2 1/2] MIPS: fix/enrich 34K APRP (APSP) functionalities
References: <1337244680-29968-1-git-send-email-dczhu@mips.com> <1337244680-29968-2-git-send-email-dczhu@mips.com> <4FB4EF81.10005@phrozen.org> <4FB60403.3080700@mips.com>
In-Reply-To: <4FB60403.3080700@mips.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


>> You could introduce a ARCH_HAS_APRP which any platform can then select ?
> 
> Hmm... This is a good idea. Maybe the name could be SYS_SUPPORTS_APRP?

You are correct

John
