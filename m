Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Sep 2012 05:34:16 +0200 (CEST)
Received: from mail-we0-f177.google.com ([74.125.82.177]:52596 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901346Ab2IPDeI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Sep 2012 05:34:08 +0200
Received: by weyr3 with SMTP id r3so3331133wey.36
        for <multiple recipients>; Sat, 15 Sep 2012 20:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rcjemwNKPbaqscMW//HK/vQZjM6O5+pnlTVp0RrZz4A=;
        b=dVBrDJXktYSjHL71Zgxilpjmj/darLjN+WtPc2xG9IKSJc4CuoycbLcnrmTelNhcLY
         pY0g4uKuHd7oaGmdUXlywTVe73cDUNo/XaCcQduXKfqwxtocedzds77TOYX1Oy7UABZE
         K6rkP5FQnCQi6lUPgzk8ERVZfXzzs/Rn48SA/nMsP+8ilCpyqBGIpjq9Alk30x2kqd+d
         4ids3h19AMmmn9WCp853NZeARyWKdsoY3E+3hzqsY6Mc3M8GxpzlSoVGWuIU8Hk5+AR4
         sU2mkJkCpb14j92RTaLGO8UjBzuyB1K6Vh2uNu8zgebN9KEg8wIIt25HTqQ9WJNQeaTE
         4MIw==
MIME-Version: 1.0
Received: by 10.180.106.97 with SMTP id gt1mr7716094wib.5.1347766443321; Sat,
 15 Sep 2012 20:34:03 -0700 (PDT)
Received: by 10.216.121.210 with HTTP; Sat, 15 Sep 2012 20:34:03 -0700 (PDT)
In-Reply-To: <50519848.6050901@openwrt.org>
References: <1347490239-1351-1-git-send-email-tdent48227@gmail.com>
        <CAFLxGvxL+2PG-MvNQTQ8a7hKaC3TBZutEBAPETDb_pkMwBSbZQ@mail.gmail.com>
        <50519848.6050901@openwrt.org>
Date:   Sat, 15 Sep 2012 23:34:03 -0400
Message-ID: <CAHXy_rONp7EULEJzH9Ari2m660hEgF_1=1gkp7RZyTWEuGZxhw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Arch: mips: Delete Makefile.rej
From:   Tracey Dent <tdent48227@gmail.com>
To:     John Crispin <blogic@openwrt.org>
Cc:     akpm@linux-foundation.org,
        richard -rw- weinberger <richard.weinberger@gmail.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tdent48227@gmail.com
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

On 9/13/12, John Crispin <blogic@openwrt.org> wrote:
> On 13/09/12 01:15, richard -rw- weinberger wrote:
>> On Thu, Sep 13, 2012 at 12:50 AM, Tracey Dent<tdent48227@gmail.com>
>> wrote:
>>> Makefile.rej should not be there. That was introduced
>>> in commit 3fa68afc3d774bab1e91cbb3a3cdd1e36068ee95 .
>> Linus' tree does not contain such a commit id.
>>

Your right but its in linux-next

>
> Hi,
>
> my bad .. its in linux-next (3fa68afc3d774bab1e91cbb3a3cdd1e36068ee95)
> and comes from the upstream-sfr tree on linux-mips.org
>
> i will talk to Ralf and fix it inside the lmo tree.

Okay

>
> Thanks,
> John
>
