Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2012 12:55:53 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:62394 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903679Ab2FVKzq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jun 2012 12:55:46 +0200
Received: by lbbgg6 with SMTP id gg6so3447628lbb.36
        for <multiple recipients>; Fri, 22 Jun 2012 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=q4UjnZd8mYlt2zY9y4SFKnszKNtfnw31A4F6FaiJYBk=;
        b=mdprwg51a3PLgMOwD5nyQwA6K/IQYpbrOO+jIGePjkZL/SevsaUkCS+4vqp5SWePvn
         LvLSxQQf1NUgFwKQofj+KPEJDQQnITP7fKFMs+06yzptFhiOVOrReLTAEftycNKUwq/w
         d1qh5Rh4WX3qlbl3OV+IYr+dsWXuc3/qXVVSItmq4j93LIN8FYTXqh9ZHlzXisnc1xT/
         tRZV5PP2GwAGsp2WFwY058XasillL6HxMdN5Clz01kbaoZzUiYyRhlFRf0Fe7Bgg5Jtx
         cQ+8gJ4AwYha1l08kRrfDejFv0EPcuRV4xnzz1nERG5P6XpuEqZYQ28CAbbFJfty2C0A
         lmrA==
MIME-Version: 1.0
Received: by 10.152.46.6 with SMTP id r6mr1742311lam.7.1340362540606; Fri, 22
 Jun 2012 03:55:40 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Fri, 22 Jun 2012 03:55:40 -0700 (PDT)
In-Reply-To: <87txy3sn20.fsf@lebrac.rtp-net.org>
References: <1340334073-17804-1-git-send-email-chenhc@lemote.com>
        <1340334073-17804-12-git-send-email-chenhc@lemote.com>
        <87txy3sn20.fsf@lebrac.rtp-net.org>
Date:   Fri, 22 Jun 2012 18:55:40 +0800
Message-ID: <CAAhV-H5q5G87UMn0ixPUVZNcEV1b_qBHJKVKmCJsmzKdEB--4A@mail.gmail.com>
Subject: Re: [PATCH V3 11/16] drm/radeon: Make radeon card usable for Loongson.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Arnaud Patard <arnaud.patard@rtp-net.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

On Fri, Jun 22, 2012 at 5:39 PM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
>
> Hi,
>
> Huacai Chen <chenhuacai@gmail.com> writes:
>
>> 1, Handle io prot correctly for MIPS.
>> 2, Define SAREA_MAX as the size of one page.
>> 3, Don't use swiotlb on Loongson machines (Loonson need swioitlb, but
>>    when use swiotlb, GPU reset occurs at resume from suspend).
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> Reviewed-by: Michel Dänzer <michel@daenzer.net>
>> Reviewed-by: Alex Deucher <alexdeucher@gmail.com>
>> Reviewed-by: Lucas Stach <dev@lynxeye.de>
>> Reviewed-by: j.glisse <j.glisse@gmail.com>
>> Cc: dri-devel@lists.freedesktop.org
>> ---
>>  drivers/gpu/drm/drm_vm.c            |    2 +-
>>  drivers/gpu/drm/radeon/radeon_ttm.c |    6 +++---
>>  drivers/gpu/drm/ttm/ttm_bo_util.c   |    2 +-
>>  include/drm/drm_sarea.h             |    2 ++
>>  4 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
>> index 961ee08..3f06166 100644
>> --- a/drivers/gpu/drm/drm_vm.c
>> +++ b/drivers/gpu/drm/drm_vm.c
>> @@ -62,7 +62,7 @@ static pgprot_t drm_io_prot(uint32_t map_type, struct vm_area_struct *vma)
>>               tmp = pgprot_writecombine(tmp);
>>       else
>>               tmp = pgprot_noncached(tmp);
>> -#elif defined(__sparc__) || defined(__arm__)
>> +#elif defined(__sparc__) || defined(__arm__) || defined(__mips__)
>>       tmp = pgprot_noncached(tmp);
>
> btw, would it be a good idea to use uncached accelerated instead ?
I have tried uncached accelerated, there will be random points in the
monitor, it seems a hw issue...

>
> Arnaud
