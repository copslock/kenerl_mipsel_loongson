Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2012 08:19:11 +0200 (CEST)
Received: from nm37-vm2.bullet.mail.ne1.yahoo.com ([98.138.229.130]:44238 "HELO
        nm37-vm2.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1903610Ab2HIUxV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2012 22:53:21 +0200
Received: from [98.138.90.48] by nm37.bullet.mail.ne1.yahoo.com with NNFMP; 09 Aug 2012 20:53:14 -0000
Received: from [98.138.89.169] by tm1.bullet.mail.ne1.yahoo.com with NNFMP; 09 Aug 2012 20:53:14 -0000
Received: from [127.0.0.1] by omp1025.mail.ne1.yahoo.com with NNFMP; 09 Aug 2012 20:53:14 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 586631.68538.bm@omp1025.mail.ne1.yahoo.com
Received: (qmail 44900 invoked by uid 60001); 9 Aug 2012 20:53:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1344545594; bh=Q2LT4jNAVGyjUu607cWwWq6MeQED+Shi4TsqGntFB+I=; h=X-YMail-OSG:Received:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=rATsRjnI4en1DLPRHBtEUYHVcRrUVZ69UmG7pHcXMPFXPBhaQ7YPpCAzjM8L+bbWVhBjYNF+nkdS/KTjKJqqv4IWSfyfgW8XBKBFPb7SXuqOLE4ZJR/qgIZTekCa7QZrGEx5vl5UY2VfjwD5VxuowyeKMH3pjiBo6cnffFD7P2Q=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4l2ZX0LZva2/d6OskB482quICLrqrfYigEajdxhQ4T7ltOcnfbnluvu+IF9TATbeBft4wzjWWU8lTWqyI1Ss6DGiQ9u9Uwer+6r1ao6vGfUkBIBq0n3NBMWaLMgmcACHGO8wpRSa2470GkqaHjbPbZE+Hzb/b/rb3l8anufjyx0=;
X-YMail-OSG: 6Ff5.YoVM1lLo0Hzp7pPwnUfNwzk.TkQ3C4OPQHG_loFfWS
 ZKeGWvoggjL6_zaJE48xvVCxa.YONj9G1jxAcKUj9FN2g3_Gpmgid1K33ugQ
 pMt5qxSdyAhbCr2x.66RYiDMNCjPJx8BriJohaqBxO6n9017m2dBBcA9lQ6q
 UMws1UBhYqiKdsTeZWqMgs3X7ihLNBIoMRB7l5jVjbOyNd4hNDMH.HUZ9nfb
 YQcGdQiaLUsdLBufJTml10K.Ewb81ASH6hTx8_VsHGI0kg7bJqZooIKnM.1x
 iltL2cdjG2libBpVx6B3KyEMm0lkppl4YHBnlPy.pHCcQVR2N1gt9JLpUir7
 iQBzwE1WHSxM2Bni8A_BCNrdrNKqaKm_38gp15ROFHCbxXYeP3_YTqv9jTyj
 q6T1L8zHYwWyEyDSkrHwqeki8qqJ9P1F9_2jylK8pJYa4ZsbLWAGG2xNojyq
 4ShBrqQPM5p0nyZ1Pa1TGU1n._xvYXNfh8_MIT5H4XdbB3F8ocjLcFmHeKM3
 T.EEn12.IPmPn1lAzyi_aA_G8D0vomOWyVccbD4bwjH0e52ZjbNsDcKWzlMU
 nBJA-
Received: from [128.18.40.201] by web120102.mail.ne1.yahoo.com via HTTP; Thu, 09 Aug 2012 13:53:14 PDT
X-Mailer: YahooMailWebService/0.8.120.356233
References: <1342922751.65328.YahooMailNeo@web120106.mail.ne1.yahoo.com> <CAJd=RBC24UXztNoKews5sE06DRvk_cBEYunHT7Zc-rdvAFF0ew@mail.gmail.com> <1343150934.42443.YahooMailNeo@web120104.mail.ne1.yahoo.com> <CAJd=RBCy+zy6jRWkpjPx43H=jqs37-L8Qij4Z5y9DYak2L643w@mail.gmail.com>
Message-ID: <1344545594.25895.YahooMailNeo@web120102.mail.ne1.yahoo.com>
Date:   Thu, 9 Aug 2012 13:53:14 -0700 (PDT)
From:   Victor Meyerson <calculuspenguin@yahoo.com>
Reply-To: Victor Meyerson <calculuspenguin@yahoo.com>
Subject: Re: Direct I/O bug in kernel
To:     Hillf Danton <dhillf@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CAJd=RBCy+zy6jRWkpjPx43H=jqs37-L8Qij4Z5y9DYak2L643w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 34086
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: calculuspenguin@yahoo.com
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

----- Original Message -----

> From: Hillf Danton <dhillf@gmail.com>
> To: Victor Meyerson <calculuspenguin@yahoo.com>
> Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>; Ralf Baechle <ralf@linux-mips.org>; LKML <linux-kernel@vger.kernel.org>
> Sent: Friday, July 27, 2012 7:47 AM
> Subject: Re: Direct I/O bug in kernel
> 
> On Wed, Jul 25, 2012 at 1:28 AM, Victor Meyerson
> <calculuspenguin@yahoo.com> wrote:
>> 
>>  Still different checksums and I used the same random-file from my first 
> test.
>> 
> Then try the fix at
>             https://lkml.org/lkml/2012/7/27/54
> 

I tried that patch, although I had to edit a slightly different line as dio_bio_alloc was near line 392 instead of 349 in the version of fs/direct-io.c in my tree.  I still got different checksums between the two files and even different checksums from my earlier attempts.

I am not sure if this helps, but Ralf asked if I can try a different page size to see if this problem occurs.  I originally had CONFIG_PAGE_SIZE_4KB=y and changed it to CONFIG_PAGE_SIZE_16KB=y (via menuconfig).  Having a page size of 16KB (and the above patch not applied) made the checksum on the files match each other and match the file made from the working kernel.

Victor
