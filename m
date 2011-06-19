Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 01:45:17 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:39318 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490993Ab1FSXpO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 01:45:14 +0200
Received: by iwn35 with SMTP id 35so2210122iwn.36
        for <linux-mips@linux-mips.org>; Sun, 19 Jun 2011 16:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ZbrbsiNSvgZRkM6g+H4kt1DcrcmcaQCQYcfup3XaiUQ=;
        b=FO2WOk3dDwLuAA0tG4u+MK8L/K2oiGm6aakdZtT/oqqd9gpHH3WU95XDVKru9scO4d
         fUiM8yAECPZQlPIcjjQh7pDEPVwPW22qZK34rSAOtf5td05J32ZLKe7C722gadyePO9V
         Lf4uykbtkcuO2dZ2Sc9Nfdp28PhwtWJLiZepA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gK4D6DPGBZFYfF2gwuW4HnAk+zqsYO1YrDLSo8FOXMIdJCt7ckBcOhs8B0ew3JvTua
         a7fY1IwyiiaVswaH37xUgz4hZTX2AdnUjYeAzYdftZ5ESvx4lUioQ7P9Os3XWAHvUqvS
         JyZuHSuNQz1SeaK0c3JHpklQwv2zwbTcJLQmU=
Received: by 10.231.28.17 with SMTP id k17mr4521895ibc.99.1308527108072; Sun,
 19 Jun 2011 16:45:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.167.71 with HTTP; Sun, 19 Jun 2011 16:44:48 -0700 (PDT)
In-Reply-To: <1308520209-668-6-git-send-email-hauke@hauke-m.de>
References: <1308520209-668-1-git-send-email-hauke@hauke-m.de> <1308520209-668-6-git-send-email-hauke@hauke-m.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 20 Jun 2011 09:44:48 +1000
Message-ID: <BANLkTinCrAMa3bmTsKpu4y7QGbSiU9jMXQ@mail.gmail.com>
Subject: Re: [RFC v2 05/12] bcma: add mips driver
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de, sshtylyov@mvista.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15740

Hauke,

One minor comment

On Mon, Jun 20, 2011 at 07:50, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
> new file mode 100644
> index 0000000..d49f9af
> --- /dev/null
> +++ b/drivers/bcma/driver_mips.c
> @@ -0,0 +1,232 @@
> +/*
> + * Sonics Silicon Backplane

Err, this is for BCMA, not SSB =)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
