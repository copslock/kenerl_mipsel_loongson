Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 16:32:06 +0100 (CET)
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34166 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008128AbbLAPcEevxGK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2015 16:32:04 +0100
Received: by qkfo3 with SMTP id o3so3790780qkf.1;
        Tue, 01 Dec 2015 07:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=g11RDYfJ/UrANY0wLpf1vq4Jjly9HX8uwUBlII6IJWs=;
        b=EhAV55ZkW6GJFAFhuftZjC130Pzyqz6qjQbwJavZdZi9Mj0WM8TnBqNIGmVk0lmgza
         i8yVaX4G7Jn2M6EqZPfwsPn+I6vuYOp11p33+8UpVVwMTxzOHOlaeIkvQqLxmgDfBF1O
         IszPEO2DzaYelIFGuZFcNrf8X6lFLMmz9wcfh818Ca05PU/NpcCzsucrlNJQg4N2Voyi
         SUIqOjl1wSaeDY7JFvlWlgvz1IZ/pNEVgTxxv540mlXSrKanZIjcaKW17ls/dnAAbPK5
         eWYJ7ZsT6O8y6hfV6hdxNagfZd041RnWqmgmcF4T3OfEmEs4gCxUU/J5a0A/Mu6P7l4M
         hKuQ==
X-Received: by 10.55.204.213 with SMTP id n82mr83458677qkl.36.1448983918201;
        Tue, 01 Dec 2015 07:31:58 -0800 (PST)
Received: from bigtime.twiddle.net (50-194-63-110-static.hfc.comcastbusiness.net. [50.194.63.110])
        by smtp.googlemail.com with ESMTPSA id b22sm17213252qge.23.2015.12.01.07.31.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Dec 2015 07:31:57 -0800 (PST)
Subject: Re: no-op delay loops
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>
References: <87si3rbz6p.fsf@rasmusvillemoes.dk> <3228673.rOyW85ILiP@wuerfel>
 <874mg3b2h5.fsf@rasmusvillemoes.dk>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
From:   Richard Henderson <rth@twiddle.net>
Message-ID: <565DBD69.7000701@twiddle.net>
Date:   Tue, 1 Dec 2015 07:31:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <874mg3b2h5.fsf@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <rth7680@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@twiddle.net
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

On 11/30/2015 01:29 PM, Rasmus Villemoes wrote:
> ./arch/alpha/boot/main.c:187:1-4: no-op delay loop

Not sure why this is there.  The runkernel function that preceeds it cannot 
return, having performed an indirect branch (not a call) to the kernel start.

I see no reason to actually change anything, unless someone insists that this 
be remove to avoid future similar analysis.


r~
