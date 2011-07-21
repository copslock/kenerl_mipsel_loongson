Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 01:02:05 +0200 (CEST)
Received: from mail-pz0-f47.google.com ([209.85.210.47]:38034 "EHLO
        mail-pz0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491808Ab1GUXBv convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jul 2011 01:01:51 +0200
Received: by mail-pz0-f47.google.com with SMTP id 36so2632686pzk.34
        for <multiple recipients>; Thu, 21 Jul 2011 16:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3B5fgtYd9zJZUmZzO+FS1IZV4/BoYfq/Dqf5LbXlv3Y=;
        b=WL0vB7dnvnrwDmde2zQbxUG3kbRrHFFFeO+481dUnMlYWJ5qkPUddwGYZEjYRDhVm5
         Apj2w8DLXaEn6HGuNpiWX9XLVbXWoWQ+SCv6XcBaGtpHZtIRU98NaUoN3wRuuVxUzhT5
         LXNjjjqGuWdJwjvsORCytTkJsWWpv4fsFh4Pg=
MIME-Version: 1.0
Received: by 10.68.27.232 with SMTP id w8mr1116258pbg.49.1311289310116; Thu,
 21 Jul 2011 16:01:50 -0700 (PDT)
Received: by 10.68.49.98 with HTTP; Thu, 21 Jul 2011 16:01:50 -0700 (PDT)
In-Reply-To: <1310835342-18877-3-git-send-email-hauke@hauke-m.de>
References: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
        <1310835342-18877-3-git-send-email-hauke@hauke-m.de>
Date:   Fri, 22 Jul 2011 01:01:50 +0200
Message-ID: <CACna6rzTqqHpqOfKNQi_T8uUEnbO_KXKGiwwMCbtWY7mX=NtSA@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] bcma: move initializing of struct bcma_bus to
 own function.
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, jonas.gorski@gmail.com, mb@bu3sch.de,
        george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15593

2011/7/16 Hauke Mehrtens <hauke@hauke-m.de>:
> This makes it possible to use this code in some other method.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Rafał Miłecki <zajec5@gmail.com>

-- 
Rafał
