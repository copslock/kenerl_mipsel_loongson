Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2012 14:18:35 +0200 (CEST)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:33264 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903556Ab2HJMS3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Aug 2012 14:18:29 +0200
Received: by vbbfo1 with SMTP id fo1so1542448vbb.36
        for <multiple recipients>; Fri, 10 Aug 2012 05:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ReNN/R3DP33BKGl7gOMZsW0+Yr0XRSOGh2ziMCVfvNE=;
        b=GJ68I2Tu1/3CtgFnNgWWcUF7L3RPH/dhPnIhKNkZnBukNMN5Uyxxe8tkgKcdbBOGRC
         1WRUfTT6FlBhbEPRFQkY1Ou3u65N3LOnvEON+SvLsTtE9TaMzewD7BHbA0N1/BKQpMr4
         iqrYX9cpYZYQLnNaGV0jC1HG0R5+2Vv7wXKqwKxXW2NiZdOrc/l7/vyQ4z9dUyOzu5jJ
         XhFG5WFVxnmIAa5u+9tNKeersH2Ce5SgqLyXvmQMky0PbD6H6RICIW7zneTYmzTLW0NZ
         uWWhbgviMCmcupqJspQhYfmQC1ceToBi1sIEEMSmK5Gkps9+VZLt+abOe+NEW0msqJI9
         W1jQ==
MIME-Version: 1.0
Received: by 10.221.13.72 with SMTP id pl8mr2320028vcb.5.1344601102632; Fri,
 10 Aug 2012 05:18:22 -0700 (PDT)
Received: by 10.220.96.148 with HTTP; Fri, 10 Aug 2012 05:18:22 -0700 (PDT)
In-Reply-To: <1344545594.25895.YahooMailNeo@web120102.mail.ne1.yahoo.com>
References: <1342922751.65328.YahooMailNeo@web120106.mail.ne1.yahoo.com>
        <CAJd=RBC24UXztNoKews5sE06DRvk_cBEYunHT7Zc-rdvAFF0ew@mail.gmail.com>
        <1343150934.42443.YahooMailNeo@web120104.mail.ne1.yahoo.com>
        <CAJd=RBCy+zy6jRWkpjPx43H=jqs37-L8Qij4Z5y9DYak2L643w@mail.gmail.com>
        <1344545594.25895.YahooMailNeo@web120102.mail.ne1.yahoo.com>
Date:   Fri, 10 Aug 2012 20:18:22 +0800
Message-ID: <CAJd=RBA=gdh-9aSeNGSu=BMNgVAWOKNy_yL7sJPUUpyee5VBjQ@mail.gmail.com>
Subject: Re: Direct I/O bug in kernel
From:   Hillf Danton <dhillf@gmail.com>
To:     Victor Meyerson <calculuspenguin@yahoo.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 34089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
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

On Fri, Aug 10, 2012 at 4:53 AM, Victor Meyerson
<calculuspenguin@yahoo.com> wrote:
> I tried that patch, although I had to edit a slightly different line as dio_bio_alloc was near line 392 instead of 349 in the version of fs/direct-io.c in my tree.  I still got different checksums between the two files and even different checksums from my earlier attempts.
>
> I am not sure if this helps, but Ralf asked if I can try a different page size to see if this problem occurs.  I originally had CONFIG_PAGE_SIZE_4KB=y and changed it to CONFIG_PAGE_SIZE_16KB=y (via menuconfig).  Having a page size of 16KB (and the above patch not applied) made the checksum on the files match each other and match the file made from the working kernel.
>

Thanks for tests, Victor.

Please elaborate on the role of page size in this case, Ralf.

Good Weekend
Hillf
