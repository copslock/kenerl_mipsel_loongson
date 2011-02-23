Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2011 04:47:19 +0100 (CET)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:47918 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490956Ab1BWDrQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Feb 2011 04:47:16 +0100
Received: by vxd2 with SMTP id 2so1474749vxd.36
        for <linux-mips@linux-mips.org>; Tue, 22 Feb 2011 19:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BkCGEJv7UhFogvi9Mj0zlSjiP584SX80047XVEWOhtk=;
        b=sQLLH68GHOrKy4KYqDejMWhvSxEjtUCWS63RZz37m1naaQEZGiOfjHjUN1ERPjMZrY
         u8SVYCXFydQvSmxOGGD0KnjtxuqMBr4Tx2pkghMnmWqf31fS3W/6QIU7jLsxHaVprEPf
         WVVARmdZVVFJKYbw9rrKK1aCx0l1hOqrGSz/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rRKSLnmpGxhTCAwSyt3u4DG6Tsxewb/hxIyQ8E18cwXuAcLKfOd8oMwIRCaBWkKuaB
         Fgm2Jcif3zd3xyMwb7TTEO1jClXAa4cCjDHTzBl0Mz3Iy8aXqh9DnSg+6WKXhVeXAInQ
         ivpKl9DjVl7cl18iMVFM76nOEn98de8dmrI/4=
MIME-Version: 1.0
Received: by 10.52.158.196 with SMTP id ww4mr5267903vdb.220.1298432828825;
 Tue, 22 Feb 2011 19:47:08 -0800 (PST)
Received: by 10.52.161.104 with HTTP; Tue, 22 Feb 2011 19:47:08 -0800 (PST)
In-Reply-To: <AANLkTimTdZtgL3kXPRzZ=BMRp8RVfx4MSn96Rny_22GO@mail.gmail.com>
References: <AANLkTimvEQEwewMDw+KiXGv2vrMbj6C4BW8A3WRzD7BG@mail.gmail.com>
        <AANLkTi=c+AqhAsdZOrVV51TC1FTw+6fCv98PQnt6snxC@mail.gmail.com>
        <AANLkTimTdZtgL3kXPRzZ=BMRp8RVfx4MSn96Rny_22GO@mail.gmail.com>
Date:   Wed, 23 Feb 2011 09:17:08 +0530
Message-ID: <AANLkTi=pvrRQE2G-8ifSBaVbvt7RYNFtNVbM=1Y792D+@mail.gmail.com>
Subject: Re: Issue on 2.6.35.9 kernel with module insertion when Rootfs is NFS mounted
From:   naveen yadav <yad.naveen@gmail.com>
To:     Mulyadi Santosa <mulyadi.santosa@gmail.com>,
        linux-mips@linux-mips.org
Cc:     kernelnewbies@nl.linux.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,

We investigated the problem and found out that there is some config issue.
The config option was the problem:-
Symbol: NFSD_V4 [=n]
    Prompt: NFS server support for NFS version 4 (EXPERIMENTAL)
      Defined at fs/nfsd/Kconfig:67
      Depends on: NETWORK_FILESYSTEMS [=y] && NFSD [=n] && PROC_FS
[=y] && EXPERIMENTAL [=y]
      Location:
        -> File systems
          -> Network File Systems (NETWORK_FILESYSTEMS [=y])
            -> NFS server support (NFSD [=n])
      Selects: NFSD_V3 [=n] && FS_POSIX_ACL [=y] && RPCSEC_GSS_KRB5 [=y]

Thanks





On Tue, Feb 22, 2011 at 9:22 AM, naveen yadav <yad.naveen@gmail.com> wrote:
> Hi ,
>
> Thanks for your answer,
>
> Yes I am sure it is from same kernel and sams GCC version,
> The same module if put in Initiramfs, works fine. only issue occur
> when I build kernel with rootfs mounted from NFS.
>
>
> On Mon, Feb 21, 2011 at 11:03 PM, Mulyadi Santosa
> <mulyadi.santosa@gmail.com> wrote:
>> Hi :)
>>
>> On Mon, Feb 21, 2011 at 20:07, naveen yadav <yad.naveen@gmail.com> wrote:
>>> Hi All,
>>>
>>> When I am trying to insert some modules on 2.6.35.9, I am getting some
>>> random crash's.
>>> There are 2 scenarios:-
>>>
>>> 1) When my rootfs is NFS mounted.
>>>
>>> In this case, when I insmod modules some get inserted and some gives crash.
>>> I have tried with following modules :-
>>> a)      ext2.ko ; size 93K ; status - successfully inserted
>>> b)      ext3.ko ; size 188K ; status - insertion failed
>>> c)      xfs.ko ; size 823K ; status - insertion failed
>>> d)      usbcore.ko ; size 243K ; status - insertion failed
>>>
>>> 2) When I created kernel Image using Initramfs, hence making all
>>> modules part of ramfs image
>>> all insertions are successfull
>>
>> Hm, easiest thing first to check: are you sure you are inserting
>> modules that belongs to the currently running kernel's version? and
>> they were compiled with the same gcc options?
>>
>> And furthermore, if they use symbol versioning, are they belong to the
>> same symbol version?
>>
>> --
>> regards,
>>
>> Mulyadi Santosa
>> Freelance Linux trainer and consultant
>>
>> blog: the-hydra.blogspot.com
>> training: mulyaditraining.blogspot.com
>>
>
