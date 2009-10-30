Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2009 15:43:46 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:39341 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493506AbZJ3Onj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Oct 2009 15:43:39 +0100
Received: by ywh3 with SMTP id 3so3021018ywh.22
        for <multiple recipients>; Fri, 30 Oct 2009 07:43:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Hk1UKvElbcqWIrNDF1/TCHHVAgByOyMuNCSbBsBr0Mo=;
        b=HXIMaZhpKnA/3LAwr+ud1hUWiXsTMiCGC6TSfH3cScCoRk1+jyYlsI5e2PlVL/7tNS
         gK1fjvjM0KQ8X0NagMWwHOo0QGY3OV+/qwiEqd2YR0wVMRBZfpedJETIgzniUfBXq5B1
         EejmYzfkM2q6WyRAq4rLLUO0kzjkxd7rh+ims=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MA3zj00MIoEbAb6f+ulQp+KBOzasXd0xPp1mZUWZx+Mprw3NmZMefyp6lLYtMOg5Pu
         g3VTKvogvkX/dYZn/ESg6KBaS017/wNRxUtbIpVVpiX7uvOzpOHn2IcWZ5OXIHNsSLJl
         ZcKMnMVffeuT48/ZawinE4DM9rK6CSF/S9t5k=
MIME-Version: 1.0
Received: by 10.101.190.32 with SMTP id s32mr1569692anp.47.1256913811752; Fri, 
	30 Oct 2009 07:43:31 -0700 (PDT)
In-Reply-To: <4AEAEF43.7060200@rw-gmbh.de>
References: <4AEAEF43.7060200@rw-gmbh.de>
Date:	Fri, 30 Oct 2009 22:43:31 +0800
Message-ID: <b00321320910300743l6ddc0f64kfd37658050d5705c@mail.gmail.com>
Subject: Re: mips: fix build of vmlinux.lds
From:	wu zhangjin <wuzhangjin@gmail.com>
To:	=?ISO-8859-1?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	sam@ravnborg.org, manuel.lauss@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Oct 30, 2009 at 9:50 PM, Ralf Rösch <ralf.roesch@rw-gmbh.de> wrote:
> Hi Ralf,
>
> could you please cherry-pick commit
>  fd6b6a85c525824bece9543fae5ed68c00ad65a7
> (or fd6b6a85c525824bece9543fae5ed68c00ad65a7, seems to be identical)
> to linux-2.6.31-stable branch and may be others too ?
>

Seems only 2.6.31 need it, because the modification of vmlinux.lds.S
was introduced in 2.6.31.5.

Regards,
Wu Zhangjin
