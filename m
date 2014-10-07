Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 21:19:38 +0200 (CEST)
Received: from mail-oi0-f42.google.com ([209.85.218.42]:49545 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010745AbaJGTTh0EobY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 21:19:37 +0200
Received: by mail-oi0-f42.google.com with SMTP id a141so5691364oig.29
        for <multiple recipients>; Tue, 07 Oct 2014 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:reply-to:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jHAvmisRgJNXnKcB49aehgjsYy6qpUU5YARdXXsDIgg=;
        b=ue1gudqD5WNh5OkU6PCzAHnc9m8PiuH5/4tcmvD5n09sYr1PzBpUmn5rFUDZtnqpld
         ftwEWBYXvl3VULsjyXxp78IEweeq68PhrBFWmTMMQTezU8HhEKuqez1Kfl92+ml/zVEh
         VuTGcG5UzUyGyQYdiKsKXS9oSuI7t3XJbMPbTK6Hvhle29vtN7JQKb/q9gERqxYblt0p
         wY6zdIg4boZl9I8QemkkH8MKGQ/uiwFFUIkdngXhHa2/+ZaILKEK9tw1Tl+8fYCP77t3
         77DDDhEaDw2kVGfIWCEhedH9X81L3WmDoxvQfaJTie4ibkgxO/iCr+eK9blEUuqslZ9X
         VO/g==
X-Received: by 10.182.19.195 with SMTP id h3mr6743724obe.43.1412709571125;
        Tue, 07 Oct 2014 12:19:31 -0700 (PDT)
Received: from t430.minyard.home (pool-173-57-152-84.dllstx.fios.verizon.net. [173.57.152.84])
        by mx.google.com with ESMTPSA id b4sm12474827oed.2.2014.10.07.12.19.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 Oct 2014 12:19:30 -0700 (PDT)
Message-ID: <54343CC0.1010309@acm.org>
Date:   Tue, 07 Oct 2014 14:19:28 -0500
From:   Corey Minyard <minyard@acm.org>
Reply-To: minyard@acm.org
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH 2/3] Move generic dwarf2 operations from x86 to asm-generic
References: <1412707854-15555-1-git-send-email-minyard@acm.org> <1412707854-15555-3-git-send-email-minyard@acm.org> <20141007191759.GN7428@linux-mips.org>
In-Reply-To: <20141007191759.GN7428@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
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

On 10/07/2014 02:17 PM, Ralf Baechle wrote:
> This will need to be reposted to linux-kernel.
>
>   Ralf
Ok, reposting the series.  Thanks.

-corey
