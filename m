Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2015 11:19:04 +0200 (CEST)
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34197 "EHLO
        mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011042AbbENJTBZZbhj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 May 2015 11:19:01 +0200
Received: by igblo3 with SMTP id lo3so8766478igb.1;
        Thu, 14 May 2015 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jR1EuSMLLpBq5EwXQdRTb2oXMdv4C6ajaGq294T1XLc=;
        b=vhReHS5ir7UqVL1vwsjMpb9xtmB6rDCssgi1ByhfrBORMARGUbgbo4t9dlhg7La+Su
         aZN0bYs2vefhXEFNbtfH7essKtt0nKu6nKisV2RiCHyASrHpwXSMTKS4oWQDNLx6JUum
         HTNoi6FQn7EssiuqupBIGXGgKzg/XCLeqVqDGZswq3jNw43or4d4AVWdZe5osKSxs+hG
         Vku4Y+by/EaeAdDjrsCqcNn2GRIbh2MxlFFj+N/MRcnCTkgX8/jdbthdUHYSj+W7B5dQ
         AoJYUZ1oKFSF/3bLEmAUdnqL1YBfKB/wegby4KUUMgCHAxgSw+H9CWvQjJ5Xn+26hZDC
         4gVQ==
MIME-Version: 1.0
X-Received: by 10.107.128.149 with SMTP id k21mr4071560ioi.7.1431595137730;
 Thu, 14 May 2015 02:18:57 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Thu, 14 May 2015 02:18:57 -0700 (PDT)
In-Reply-To: <5554625C.4070403@imgtec.com>
References: <1431589370-30147-1-git-send-email-zajec5@gmail.com>
        <5554625C.4070403@imgtec.com>
Date:   Thu, 14 May 2015 11:18:57 +0200
Message-ID: <CACna6ryk3AYUeh738nPmcOh1BLcn+VzaZ6p4hYJSZppWr=Ts2A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Fix regression in reading WiFi SoC SPROM
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47395
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

On 14 May 2015 at 10:52, Markos Chandras <Markos.Chandras@imgtec.com> wrote:
> On 05/14/2015 08:42 AM, Rafał Miłecki wrote:
>> In the recent SPROM commit:
>> MIPS: BCM47xx: Read board info for all bcma buses
>> a proper handling of "fallback" argument has been dropped. Restore it.
>>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>> ---
> if the "MIPS: BCM47xx: Read board info for all bcma buses" is not
> upstream yet (I can't see it) it might make sense to fold this fix into
> it and repost it as v2.

It's not upstream in Linus's tree, but it was already pushed by Ralf
to his tree:
http://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=c6d94e9354139e8a0ef3bd3286b2a5ac30f8f6aa

I'll just let Ralf decide if he wants to rebase.

-- 
Rafał
