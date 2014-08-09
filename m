Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Aug 2014 07:40:16 +0200 (CEST)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:54457 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6898962AbaHIFaQ0jfDM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 9 Aug 2014 07:30:16 +0200
Received: by mail-ig0-f181.google.com with SMTP id h3so2025919igd.14
        for <multiple recipients>; Fri, 08 Aug 2014 22:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GWVdb3zQzeIyWk8mo4P8E/V/4CRqrnevb0yMfXiE/CY=;
        b=H8GevPSsh6yCyFQhZtrdCiBBpPNhWaPTmwk3ORUOPgwzf8B5yAgOs5kY9sGKdS09sv
         G/3N2kUMNIByCCbLOl14BsPUaa8kj8nWRDW37Q2Wv/lwxIeolwKSJ27kDh/TvsBb/H7w
         8EMFe39G02TBkaXztwkyRrhJcDGGIAcjsh2OgTDfxwguIvI8Xwi6cXgT8TtZaKtVqAVy
         lNhn8BO+GK6TeEf3rPQNXgF9QyoiHv1xmxL00ucfR4FQnek/LU+iYVcuGuS07DheMpKw
         IeJqnmDqVvu6qy50Q9bRuwBtu3POtDlhAWLlYN4/pa7ie1rIMQxnIQGmlbj9Oxvm9KR7
         598g==
MIME-Version: 1.0
X-Received: by 10.50.142.6 with SMTP id rs6mr11183622igb.39.1407562209850;
 Fri, 08 Aug 2014 22:30:09 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Fri, 8 Aug 2014 22:30:09 -0700 (PDT)
In-Reply-To: <1407538185-23497-1-git-send-email-hauke@hauke-m.de>
References: <1407538185-23497-1-git-send-email-hauke@hauke-m.de>
Date:   Sat, 9 Aug 2014 07:30:09 +0200
Message-ID: <CACna6rxOYxVw51ZDLmdyy9+AOb56FAwFDKT04BV0UreSUUyJRw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: fix reboot problem on BCM4705/BCM4785
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 9 August 2014 00:49, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This adds some code based on code from the Broadcom GPL tar to fix the
> reboot problems on BCM4705/BCM4785. I tried rebooting my device for ~10
> times and have never seen a problem. This reverts the changes in the
> previous commit and adds the real fix as suggested by Rafał.
>
> Setting bit 22 in Reg 22, sel 4 puts the BIU (Bus Interface Unit) into
> async mode.

Nice work, thanks!
