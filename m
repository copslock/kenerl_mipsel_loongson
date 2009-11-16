Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 18:10:09 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:48790 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493416AbZKPRKC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2009 18:10:02 +0100
Received: by pwi15 with SMTP id 15so3505553pwi.24
        for <multiple recipients>; Mon, 16 Nov 2009 09:09:56 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=SLaws4XoPjSdF5FgPWnM3H8wa4weQKUVVcZKTt4EaQY=;
        b=FNfpfKoPKUz3So3f0+12qOoTe2rIHJAagtsiFE1bwx3jUtVJvR1afVUtFsTFPhGNtX
         35+sVvWCcNVbekgRQvIcwZfcGdKJvDeiNMbnFEupOrtIkmg8ziYdL2TwFYYJOXjU7xr7
         StOygaaaETTIXPFK48CirGqTo02Qp6byFXGQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=t5eBWvb7OAQjq1BaxzIKrgCmSG06jWDCMvKSyy90s07ga2DIjH2Mgt2PZIXnd7IbwY
         i7RhGoF5Q0GRME2EaeRW51IPqwFh/NcmtuHC9mJKaIgPAl+TImknUPQx/UENW1Pm3Cl1
         yqqbLxSLL6wq1ureKS2stxJ+Rd1l/+g4H9Kew=
Received: by 10.114.45.2 with SMTP id s2mr7807122was.122.1258391396165;
        Mon, 16 Nov 2009 09:09:56 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1683292pzk.12.2009.11.16.09.09.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 09:09:55 -0800 (PST)
Subject: Re: [PATCH 0/2] Add Lemote NAS and Lynloong support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20091116170111.GC14948@linux-mips.org>
References: <cover.1258390323.git.wuzhangjin@gmail.com>
	 <20091116170111.GC14948@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Tue, 17 Nov 2009 01:09:49 +0800
Message-ID: <1258391389.15821.18.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-11-16 at 18:01 +0100, Ralf Baechle wrote:
> On Tue, Nov 17, 2009 at 12:58:13AM +0800, Wu Zhangjin wrote:
> 
> > The following two patches add support for NAS & Lynloong made by Lemote, These
> > two machines are basically the same as fuloong2f, only a few part of
> > differences.
> > 
> > Hi, Ralf, Could you please queue them to 2.6.33? I will delay the left drivers
> > to 2.6.34.
> 
> What driver patches you got pending?

the CPUFreq driver for loongson2f and the platform drivers for
yeeloong2f netbook and lynloong pc.

is the time enough to upstream them? and again, where should I put the
platform drivers in(I have incorporated with your feedbacks)? in
arch/mips or drivers/platform/mips ?

and I will send the lastest CPUFreq driver asap.

Best Regards,
	Wu Zhangjin
