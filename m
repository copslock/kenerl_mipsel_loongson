Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2012 20:28:17 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:45393 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903385Ab2INS2L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2012 20:28:11 +0200
Received: by ghbf20 with SMTP id f20so204708ghb.36
        for <multiple recipients>; Fri, 14 Sep 2012 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TO7CHP86HVRKKc7jS5h6wLqka9+Nb33RJAGJnDHWznM=;
        b=yfaPJBMoJyTtHIiFRgpSfFxOq2esEthaXLVwfTAZch6XHM6MS57hC2gWcjIqW6/CU9
         Urj+/3yRFVdhK5a2M5HBuzSM7vfajKmFxY5vvtttVwqU6/t3fZZhjm+GeZPBhLoF/q2S
         cbacGzXemH91vlLKxL3LPBIeVUpbjLjZ9nXmzFc+3xSIHwT4jN4m6DNem/I9G8kkEsGy
         s52YL6ufx5C2GDwG1bHlataf7MWspnCmbzctM6l0TR0DvYk/cf9dlzAoyfzE8SP6wEqq
         0T2meoYEXpe3R+Beg04i5TEoS43N8fjXakOn3X+I0Qko3c+T6wp90MZGE1HCDJPGy9bf
         /1/w==
Received: by 10.236.189.38 with SMTP id b26mr4619519yhn.85.1347647284849; Fri,
 14 Sep 2012 11:28:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.176.229 with HTTP; Fri, 14 Sep 2012 11:27:24 -0700 (PDT)
In-Reply-To: <20120914182406.GF19592@linux-mips.org>
References: <1347639900-3734-1-git-send-email-manuel.lauss@gmail.com> <20120914182406.GF19592@linux-mips.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 14 Sep 2012 20:27:24 +0200
Message-ID: <CAOLZvyFiWDaciKiYgjxST_bFXFS0SnNFc8xdg1oQN8o053UC5w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: merge PB1100/1500 support into DB1000 code.
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Fri, Sep 14, 2012 at 8:24 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Thanks, queued.
>
> I love this patch series.  So many fewer defconfigs to test :-)

Thank you, that was one of my main motivations.

Manuel
