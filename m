Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 04:07:24 +0100 (CET)
Received: from mail-pb0-f50.google.com ([209.85.160.50]:46906 "EHLO
        mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822197Ab2LLDHX0HAE3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 04:07:23 +0100
Received: by mail-pb0-f50.google.com with SMTP id wz7so134581pbc.23
        for <linux-mips@linux-mips.org>; Tue, 11 Dec 2012 19:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=AXcc5Eq99161lzFJvTaCxrnO6e8wTJzfXq9SVlSWDck=;
        b=S3m8NfFNAR+SUOCm7Rnv2DPzXbPO6dkbMPeWgOfe12eDLZt73tjMf7osyknmncn72u
         XaE9F72soe3SkTE11zpGW6NZqCowRBCJ8GEkQyo4+16yCVD+yFDxVxPKwM/rSomEI0VA
         ksS/r+HA2YvoaK5JqNILeubEchIVvowDJNTnmo8KSZ+Ss8gpArlJgxJYOSFVCP5O4gxS
         RSIErUSuGRqc2VXc0PqcLk8SSIWWR1KbfIMe1Pb4gzoEL1ICuIPSavI7vIeljDra/NeH
         14ifT/iXx33BlN2eMEFv9AgEFWINf5mkWcl+HN7jAsuLdyFUjSVZbtK8EDENQhWLbTea
         C1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type:x-gm-message-state;
        bh=AXcc5Eq99161lzFJvTaCxrnO6e8wTJzfXq9SVlSWDck=;
        b=iL4AN0TcXUqo66dVmgLsUXpJRRgXAvf2dcYTYvoSZGEiuqPdsSPMgk6vM9Yyzz9Qh/
         3hc3vL/v6fEOH/JHTwYxHL0wZ8deWvBZ8U4sOUUBhNrUKuV7+0cuvlG8j3g23X1NlhYE
         voUgo2jMNRa/MbMpeI+aYYggfHNoqzkOZqYKfefmwIzAjSVv6Sgbpo8lNxwpPB/KfLsw
         2w9xze9f2gJkjpFvVNFhnA97kg5QEqdsiOhY22nERiVTvguhe8gzWG0wIODicAbh7kDp
         jZK9M4af1Ht8SWoccZnHH1mkSD2y7/18Phls0JVCl5zcL07mGN8ilYLowsAMw8cyJZuH
         PF7w==
Received: by 10.66.88.198 with SMTP id bi6mr1307299pab.54.1355281636043;
        Tue, 11 Dec 2012 19:07:16 -0800 (PST)
Received: from [2620:0:1008:1101:be30:5bff:fed8:5e64] ([2620:0:1008:1101:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id o5sm1059149pay.5.2012.12.11.19.07.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2012 19:07:15 -0800 (PST)
Date:   Tue, 11 Dec 2012 19:07:14 -0800 (PST)
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
In-Reply-To: <1354881215-26257-1-git-send-email-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.00.1212111906270.18872@chino.kir.corp.google.com>
References: <1354881215-26257-1-git-send-email-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Gm-Message-State: ALoCoQm8Z9ciarVszOTVfJau6SGwPkGGVVmQAl1Ul/hRQEja+GcrU8eZ0HK1qVWaUo2jF8zdp0Kq6tTt+GN4MjSA3GJwUvQ/o5HXdj/cUmOC6a8IwhFm+dTodiLQye7H/JT0upPNaH0ZBN0UZZNULNJHDJhE5AIW1n1138RY0+aFMILJW8YYeNR7wtofCJpAr4LY2LKexwp1QLk7LwjoR/HABF//2fPa+g==
X-archive-position: 35255
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

On Fri, 7 Dec 2012, Kirill A. Shutemov wrote:

> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> We have two different implementation of is_zero_pfn() and
> my_zero_pfn() helpers: for architectures with and without zero page
> coloring.
> 
> Let's consolidate them in <asm-generic/pgtable.h>.
> 

What's the benefit from doing this other than generalizing some per-arch 
code?  It simply adds on more layer of redirection to try to find the 
implementation that matters for the architecture you're hacking on.
