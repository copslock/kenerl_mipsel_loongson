Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Dec 2014 07:41:38 +0100 (CET)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:56307 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006516AbaLVGlgLeEdq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Dec 2014 07:41:36 +0100
Received: by mail-ie0-f170.google.com with SMTP id rd18so3864356iec.15;
        Sun, 21 Dec 2014 22:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=se1IZpmaSXLU2kZ2niTMKWiOoNyywJaVoczPTzU0hqc=;
        b=tqNsfRRp8cMaIOsYHiwyg0RJQFzhFeRVwA6GIyFQXp4ePcCiAzNsEdupUYZ1WGIB6Y
         XdMVSMapUJyDgVU4POwmF3jMlyR3DwJDG024bg7R/HuXQ29C7sdBO76n7MCPbi8/tftH
         oZ0UYR0LJtCoNH9sq8BOrd0HXj9OSnVIY5XFSy1gzuHQqB2u8kE30NBFP3B0dkIZFUXD
         ViXWxiOzjuxaLfV32batR/PIZDmWOxCEmF0tZjI4r8SbabVE6VS327G3dI1nCpZtjR9U
         n0uAmHl7KFkYDBsYWp8epvnR8V6mLT7/80+w9Ei+V/BwqUm751v9A2Qa75GRX9HGpHkR
         Hfpw==
MIME-Version: 1.0
X-Received: by 10.50.17.99 with SMTP id n3mr1746044igd.21.1419230486979; Sun,
 21 Dec 2014 22:41:26 -0800 (PST)
Received: by 10.107.4.79 with HTTP; Sun, 21 Dec 2014 22:41:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1412102300090.29716@utopia.booyaka.com>
References: <1418212587-19774-1-git-send-email-zajec5@gmail.com>
        <alpine.DEB.2.02.1412102300090.29716@utopia.booyaka.com>
Date:   Mon, 22 Dec 2014 07:41:26 +0100
Message-ID: <CACna6rxCnCfUToh_j61Jxc2wvVs9xZNvrdCXwd-SNS-JADHs+Q@mail.gmail.com>
Subject: Re: [PATCH][RFC] MIPS: BCM47XX: Move NVRAM driver to the drivers/firmware/
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>,
        Jeff Garzik <jgarzik@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt.fleming@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-soc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 11 December 2014 at 00:16, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 10 Dec 2014, Rafał Miłecki wrote:
>
>> After Broadcom switched from MIPS to ARM for their home routers we need
>> to have NVRAM driver in some common place (not arch/mips/).
>> We were thinking about putting it in bus directory, however there are
>> two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
>> won't fit there neither.
>> This is why I would like to move this driver to the drivers/firmware/
>>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>> ---
>> Hey, this is another try for the NVRAM driver. At first I tried moving it to the
>> drivers/misc/, but then decided drivers/soc/ will be better. Then after
>> discussion with Paul we decided to try drivers/firmware/ and so I do.
>>
>> Meanwhile I've sent few patches cleaning nvram.c: following kernel coding style
>> and using helpers like readl.
>>
>> I would like to get few Reviewed-by for this patch. If I get that, then I'll
>> re-send this patch to Ralf without the RFC.
>>
>> If you want to review nvram.c code, please make sure to check version in
>> ralf/upstream-sfr.git repository as it contains many cleanups:
>> git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git
>> http://git.linux-mips.org/cgit/ralf/upstream-sfr.git/log/
>>
>> Mentioned patches (more cleanups):
>> http://patchwork.linux-mips.org/project/linux-mips/list/?submitter=478
>>
>> Finally: why drivers/firmware/? Please see Paul's e-mail:
>> <alpine.DEB.2.02.1411271926560.1406@utopia.booyaka.com>
>> http://www.linux-mips.org/archives/linux-mips/2014-11/msg00678.html
>>
>> Unfortunately there is no mailing list for drivers/firmware/, so I've
>> picked ppl with 5+ commits to this directory. Hope this is OK.
>
> Reviewed-by: Paul Walmsley <paul@pwsan.com>
>
> Just to restate, if it's unclear for any other reviewers (as it initially
> was for me): this isn't an NVRAM driver as most folks understand the term.
> This "NVRAM" code parses SoC configuration data that is passed to the
> kernel in flash from the bootloader firmware, "CFE".

Thanks Paul.

Could anyone else review this, please?

-- 
Rafał
