Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 14:53:06 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:64807 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491130Ab1C3MxD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2011 14:53:03 +0200
Received: by qyl38 with SMTP id 38so905914qyl.15
        for <linux-mips@linux-mips.org>; Wed, 30 Mar 2011 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OhBETm2sFq2S8CsdHOx2mttahKTmhELxAYUuLwOJ/Ko=;
        b=sVKO8wvyaxUJPIzW0Kb8/xLCN1QL1jONqTgatHihrgRVWxlYcN8ZkBW0/nXJtYKJNx
         R6U7LHqWz/WSv19+yb5iU0UgBFjnyRTegRBVHbbqrHto2OXIkZBO+nUbHTVCIH3RxYvf
         qD0SiNZ4VVGJM0ucFkSwSr0g2VkDrg2ugrPqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mKqckMy2KkKs0uQSZiHipuWD3OgRIrNcKNuF2A0nO5jVERrwIMhOw/5M9Z50TzlbZf
         vml5mSOkRErlhP8TMHv1JnIxtgLmcx9Iwbx6ptuLHeAu97W6H8HKN31PeDlRqC4dfvxS
         GOgRo8lS0Q/XHiOp7gdMhqU3Px2WtxBPRHT6g=
MIME-Version: 1.0
Received: by 10.224.138.14 with SMTP id y14mr1008274qat.31.1301489577530; Wed,
 30 Mar 2011 05:52:57 -0700 (PDT)
Received: by 10.224.2.146 with HTTP; Wed, 30 Mar 2011 05:52:57 -0700 (PDT)
In-Reply-To: <1301488032.3283.42.camel@edumazet-laptop>
References: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
        <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
        <1300960540.32158.13.camel@e102109-lin.cambridge.arm.com>
        <AANLkTim139fpJsMJFLiyUYvFgGMz-Ljgd_yDrks-tqhE@mail.gmail.com>
        <1301395206.583.53.camel@e102109-lin.cambridge.arm.com>
        <AANLkTim-4v5Cbp6+wHoXjgKXoS0axk1cgQ5AHF_zot80@mail.gmail.com>
        <1301399454.583.66.camel@e102109-lin.cambridge.arm.com>
        <AANLkTin0_gT0E3=oGyfMwk+1quqonYBExeN9a3=v=Lob@mail.gmail.com>
        <AANLkTi=gMP6jQuQFovfsOX=7p-SSnwXoVLO_DVEpV63h@mail.gmail.com>
        <1301476505.29074.47.camel@e102109-lin.cambridge.arm.com>
        <AANLkTi=YB+nBG7BYuuU+rB9TC-BbWcJ6mVfkxq0iUype@mail.gmail.com>
        <AANLkTi=L0zqwQ869khH1efFUghGeJjoyTaBXs-O2icaM@mail.gmail.com>
        <AANLkTi=vcn5jHpk0O8XS9XJ8s5k-mCnzUwu70mFTx4=g@mail.gmail.com>
        <1301485085.29074.61.camel@e102109-lin.cambridge.arm.com>
        <AANLkTikXfVNkyFE2MpW9ZtfX2G=QKvT7kvEuDE-YE5xO@mail.gmail.com>
        <1301488032.3283.42.camel@edumazet-laptop>
Date:   Wed, 30 Mar 2011 15:52:57 +0300
Message-ID: <AANLkTikX0jxdkyYgPoqjvC5HzY8VydTbFh_gFDzM8zJ7@mail.gmail.com>
Subject: Re: kmemleak for MIPS
From:   Daniel Baluta <daniel.baluta@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Maxin John <maxin.john@gmail.com>,
        naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <daniel.baluta@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.baluta@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 30, 2011 at 3:27 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> Le mercredi 30 mars 2011 à 13:17 +0100, Maxin John a écrit :
>> A quick observation from dmesg after placing printks in
>> "net/ipv4/udp.c" for MIPS-malta
>>
>> CONFIG_BASE_SMALL : 0
>> table->mask : 127
>> UDP_HTABLE_SIZE_MIN :  256
>>
>> dmesg:
>> ....
>> ...
>> TCP: Hash tables configured (established 8192 bind 8192)
>> TCP reno registered
>> CONFIG_BASE_SMALL : 0
>> UDP hash table entries: 128 (order: 0, 4096 bytes)
>> table->mask, UDP_HTABLE_SIZE_MIN : 127 256
>> CONFIG_BASE_SMALL : 0
>> UDP-Lite hash table entries: 128 (order: 0, 4096 bytes)
>> table->mask, UDP_HTABLE_SIZE_MIN : 127 256
>> NET: Registered protocol family 1
>> ....
>> ....
>>
>> printk(s) are placed in udp.c as listed below:
>>
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index 588f47a..ca7f6c6 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -2162,7 +2162,7 @@ __setup("uhash_entries=", set_uhash_entries);
>>  void __init udp_table_init(struct udp_table *table, const char *name)
>>  {
>>         unsigned int i;
>> -
>> +       printk("CONFIG_BASE_SMALL : %d \n", CONFIG_BASE_SMALL);
>>         if (!CONFIG_BASE_SMALL)
>>                 table->hash = alloc_large_system_hash(name,
>>                         2 * sizeof(struct udp_hslot),
>> @@ -2175,6 +2175,8 @@ void __init udp_table_init(struct udp_table
>> *table, const char *name)
>>         /*
>>          * Make sure hash table has the minimum size
>>          */
>> +       printk("table->mask, UDP_HTABLE_SIZE_MIN : %d %d
>> \n",table->mask,UDP_HTABLE_SIZE_MIN);
>> +
>>         if (CONFIG_BASE_SMALL || table->mask < UDP_HTABLE_SIZE_MIN - 1) {
>>                 table->hash = kmalloc(UDP_HTABLE_SIZE_MIN *
>>                                       2 * sizeof(struct udp_hslot), GFP_KERNEL);
>> ~
>
>
> How much memory do you have exactly on this machine ?
>
> alloc_large_system_hash() has no parameter to specify a minimum hash
> table, and UDP needs one.
>
> If you care about losing 8192 bytes of memory, you could boot with

I can live with this, but is bad practice to have leaks even small ones.
Our concern was, to see if kmemleak with Maxin's patch
generates false positives.

So, I guess everything is fine regarding udp_init_table. We can move on,
integrating MIPS support for kmemleak :).

thanks,
Daniel.
