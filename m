Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 10:20:27 +0200 (CEST)
Received: from bues.ch ([80.190.117.144]:52647 "EHLO bues.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491041Ab1FHIUW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jun 2011 10:20:22 +0200
Received: by bues.ch with esmtpsa (Exim 4.69)
        (envelope-from <m@bues.ch>)
        id 1QUDzj-0003ZH-BR; Wed, 08 Jun 2011 10:20:07 +0200
Date:   Wed, 8 Jun 2011 10:20:01 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Arend van Spriel <arend@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        George Kashperko <george@znau.edu.ua>,
        Greg KH <greg@kroah.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "mb@bu3sch.de" <mb@bu3sch.de>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "bernhardloos@googlemail.com" <bernhardloos@googlemail.com>
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
Message-ID: <20110608102001.294a4ff2@maggie>
In-Reply-To: <BANLkTikUqj-R72XaOXnifhKv-n1ZSJMxDQ@mail.gmail.com>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <201106061503.14852.arnd@arndb.de>
        <4DED48EA.7070001@hauke-m.de>
        <201106062353.40470.arnd@arndb.de>
        <4DEDF98C.6020905@broadcom.com>
        <4DEE9BCD.1030304@hauke-m.de>
        <BANLkTikUqj-R72XaOXnifhKv-n1ZSJMxDQ@mail.gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m@bues.ch
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6566

On Wed, 8 Jun 2011 02:06:11 +0200
Rafał Miłecki <zajec5@gmail.com> wrote:

> Because full scanning needs one of the following:
> 1) Working alloc - not possible for SoCs

Isn't there a bootmem allocator available on MIPS?
