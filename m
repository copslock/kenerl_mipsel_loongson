Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 12:31:14 +0100 (CET)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:49642 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825737Ab3CLLbNY0fq0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Mar 2013 12:31:13 +0100
Received: by mail-ob0-f178.google.com with SMTP id wd20so4281465obb.23
        for <multiple recipients>; Tue, 12 Mar 2013 04:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=XfcYipj6tHYKllWf8R0wqG0zc4LK17rZShT5ZBBA1ww=;
        b=Lgp6NGr1rvcW7bfJ7uYE67YBTGwtR6cupV2QMPZUKWZyGsVX3QUPhPEDzygEYjxGZ7
         bcmySqn+lmvKZiLq7aUi31HKlWpKMRZq0uGSLy9VKk/QCXbCwPvBC5MrTFARcytCzmGp
         4GriH19WFJnsnnP2tCb1IdieIUe63gNXQceStQiZMk5AdB95hDOHMovVHN36OksBlq2w
         1Rwm2AE1Onx/JTRog/CW3W69MfW/2PRuhWmXaP79tBnJz9guBfUe2W9WTfXIvQNGrStu
         iar3unDWg590HXl1ghs8IAsZlKyVPbJJsK9Ye27Bp3FJh1CuXmDiFtpcKFmnj8ldTajQ
         pBuw==
MIME-Version: 1.0
X-Received: by 10.60.26.72 with SMTP id j8mr11686604oeg.2.1363087866782; Tue,
 12 Mar 2013 04:31:06 -0700 (PDT)
Received: by 10.182.105.164 with HTTP; Tue, 12 Mar 2013 04:31:06 -0700 (PDT)
In-Reply-To: <513F0EC8.60709@cogentembedded.com>
References: <1363073281-9939-1-git-send-email-silviupopescu1990@gmail.com>
        <513F0EC8.60709@cogentembedded.com>
Date:   Tue, 12 Mar 2013 13:31:06 +0200
Message-ID: <CAPWTe+JGm07zp62EZCzPYGvorrZHLoS6Nz0WORv-o56zdCfudQ@mail.gmail.com>
Subject: Re: [PATCH v2] pci: convert to devm_ioremap_resource()
From:   Silviu Popescu <silviupopescu1990@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, juhosg@openwrt.org,
        blogic@openwrt.org, kaloz@openwrt.org, xsecute@googlemail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: silviupopescu1990@gmail.com
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

On Tue, Mar 12, 2013 at 1:17 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 12-03-2013 11:28, Silviu-Mihai Popescu wrote:
>
>> Convert all uses of devm_request_and_ioremap() to the newly introduced
>> devm_ioremap_resource() which provides more consistent error handling.
>
>
>> devm_ioremap_resource() provides its own error messages so all explicit
>> error messages can be removed from the failure code paths.
>
>
>    There were no error messages as far as I could see, so this passage seems
> superfluous...

Sorry for that, I sent a refreshed version of the patch.

Thanks,
Silviu
