Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 23:55:07 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42128 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831627Ab2LLWzFusmx0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 23:55:05 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi1so948777pad.36
        for <linux-mips@linux-mips.org>; Wed, 12 Dec 2012 14:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=05+xC4fgB6q12pou/KeBZJUaZRI19bHQ4h7zg86XZ/Q=;
        b=jaXxxHKtcWHNODDn+0qAT+oKB3ptWEM88mymZquMWmHrY2KzJeBzSztGr73GGjgl1v
         8ATpnsftrFJHUK4JfE98oBf598bvl0+c9SDh4qi05a0quLJ/lQRJ5Ap+5zK3gnQDWJwf
         Ql0LDd6XgctRDsogyD4v1beaB3Wv3EFuAT14P7VEHK69tCsr94PBb2+QkMPYuXupGu5B
         1pJqNw0Mxkcw157zqtB3SlSqLmfPejsfCYuHY3UY4p5LpCS/m2KaCfP1Tvl2aSsN78/U
         SC/RTM6dqIdF+bWFwWqu8JINNy2C8UB8fV3uvCmpt6puUf8lWRPGAiQgzJIug6x0vtlY
         Qvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type:x-gm-message-state;
        bh=05+xC4fgB6q12pou/KeBZJUaZRI19bHQ4h7zg86XZ/Q=;
        b=PWVhZZmksaSViZQS4pt9YQQ50otV5iJpP0yaFHcZ+osT1hq02FMlRcr8UF5o1dBB6i
         jydyX0zJWtGVWCmDT2dIrk6t1ByX2AV74K6082mZrTF29JOO/P5QHNCfhN838w+As4BV
         nCdwn8lSLPSkSBlGmYydaEPKQxiCrhHMoEPwYc4P5KeE3XLMhde931Xz9yXoalBigbzM
         RYvmb3SwZGo863ILJ51Yvy/h6ayThRfe1D93M6511aaTB5hAJOCqTwLbTKTjcB/qJGcX
         0HJsfgVfQJOPZbpHWYtLrvOXTrQorqBxIWnipPEvpwFJjs2X7jGl2PJVl+F1P4iIVd+H
         SAWw==
Received: by 10.68.230.135 with SMTP id sy7mr6851311pbc.76.1355352897459;
        Wed, 12 Dec 2012 14:54:57 -0800 (PST)
Received: from [2620:0:1008:1101:be30:5bff:fed8:5e64] ([2620:0:1008:1101:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id pl10sm5570717pbc.60.2012.12.12.14.54.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 14:54:56 -0800 (PST)
Date:   Wed, 12 Dec 2012 14:54:55 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH, RESEND] asm-generic, mm: pgtable: consolidate zero page
 helpers
In-Reply-To: <20121212105538.GA14208@otc-wbsnb-06>
Message-ID: <alpine.DEB.2.00.1212121452430.23465@chino.kir.corp.google.com>
References: <1354881215-26257-1-git-send-email-kirill.shutemov@linux.intel.com> <alpine.DEB.2.00.1212111906270.18872@chino.kir.corp.google.com> <20121212105538.GA14208@otc-wbsnb-06>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Gm-Message-State: ALoCoQnkre78oUxp73D0SbOFdaZSqKo5T6w6CFvvUxBJ1ETnRSrzPYcxzoDuHikqHVeyyYvkIrJjSKfxw+PeEFvFpsmi3i2NbT6mmTmuSYABlzQqJTyc6WAdeC94vjmjhVg48rHRej8RW6oESKvJz6nwpjr6cAMxrwISg+uPWNjKHCVdNEcWwyfkH5FKYjRFOCeL0Wu24VbdtvfyR5PZx4vyZYZzxtF8Jw==
X-archive-position: 35277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 12 Dec 2012, Kirill A. Shutemov wrote:

> > What's the benefit from doing this other than generalizing some per-arch 
> > code?  It simply adds on more layer of redirection to try to find the 
> > implementation that matters for the architecture you're hacking on.
> 
> The idea of asm-generic is consolidation arch code which can be re-used
> for different arches. It also makes support of new arches easier.
> 

Yeah, but you're moving is_zero_pfn() unnecessarily into a header file 
when it is only used mm/memory.c and it adds a __HAVE_* definition that we 
always try to reduce (both __HAVE and __ARCH definitions are frowned 
upon).  I don't think it's much of a win to obfuscate the code because 
mips and s390 implement colored zero pages.
