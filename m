Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 01:01:43 +0200 (CEST)
Received: from mail-pz0-f47.google.com ([209.85.210.47]:38034 "EHLO
        mail-pz0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491803Ab1GUXBd convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jul 2011 01:01:33 +0200
Received: by pzk36 with SMTP id 36so2632686pzk.34
        for <multiple recipients>; Thu, 21 Jul 2011 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xXAj/GV5d3WYrKihUNBB/i9eDyWPuJp+MdcL7k9b7Hk=;
        b=mRlYAAPtJNzbkf6MguLAmpkMXqn+Ix38wW1gk5gCj+zJ/jmD9AC5ArXbEii4FrPZ7P
         hI+02i8Gz6HwCCZ6DkybjLKUjGhAduI+W7OE5GYBgg3UpK9zbKm7rWgbbqtUPWkJZSSH
         D56D4M6fFJjgbUU6vEg8xGokDQ5WTSGC/mXI4=
MIME-Version: 1.0
Received: by 10.68.27.135 with SMTP id t7mr1258335pbg.183.1311289286668; Thu,
 21 Jul 2011 16:01:26 -0700 (PDT)
Received: by 10.68.49.98 with HTTP; Thu, 21 Jul 2011 16:01:26 -0700 (PDT)
In-Reply-To: <1310835342-18877-2-git-send-email-hauke@hauke-m.de>
References: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
        <1310835342-18877-2-git-send-email-hauke@hauke-m.de>
Date:   Fri, 22 Jul 2011 01:01:26 +0200
Message-ID: <CACna6rxugXiGd87hk_d5tK8NM0m9v_hjJ8o7xyQhkn=j9ocOJg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] bcma: move parsing of EEPROM into own function.
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, jonas.gorski@gmail.com, mb@bu3sch.de,
        george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15592

2011/7/16 Hauke Mehrtens <hauke@hauke-m.de>:
> Move the parsing of the EEPROM data in scan function for one core into
> an own function. Now we are able to use it in some other scan function
> as well.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Rafał Miłecki <zajec5@gmail.com>

-- 
Rafał
