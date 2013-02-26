Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Feb 2013 15:55:05 +0100 (CET)
Received: from mail-ee0-f54.google.com ([74.125.83.54]:41674 "EHLO
        mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823907Ab3BZOzBNOskf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Feb 2013 15:55:01 +0100
Received: by mail-ee0-f54.google.com with SMTP id c41so2468669eek.41
        for <linux-mips@linux-mips.org>; Tue, 26 Feb 2013 06:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-type:content-transfer-encoding
         :x-mailer:thread-index:content-language:x-gm-message-state;
        bh=6RgI3oV8uf5xQUmef9sfEYVW8mL8EYzqqhk3KHimCtI=;
        b=ahedxSS7/OkMNnNiVZCBNl0OF25ie86Zxy0jeKASgwOHSO5OHgGIZgiLnUT7j32gcs
         bb6O/dPisjSS6mZ8La/34DWeZFFBEbD3jfdSai147v2zmwwBuAjclUECVvgXhrPLta72
         D9GkSItUBMnRxDurkfSQA+XQxk+0Orr5IFg1jrFw3aB4UKlWZvp1DuWj1xCa5DdozHEA
         aHnuF7iWxhLOH2Yi8IxJYMhmjicMa4nDxwaOL5xEI+PF6LY4sjKdRRwUNWSFZXYNkqbj
         KfIGuD707L8odeIbhyTMfd8kaPJlGWeQ3WPpNDxgkz8rb+V7kF8ySJ5jXGbuTsmG1fKs
         mncg==
X-Received: by 10.14.179.194 with SMTP id h42mr50197864eem.46.1361890495848;
        Tue, 26 Feb 2013 06:54:55 -0800 (PST)
Received: from hotrod ([77.70.100.51])
        by mx.google.com with ESMTPS id 3sm1876437eej.6.2013.02.26.06.54.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 26 Feb 2013 06:54:54 -0800 (PST)
From:   "Svetoslav Neykov" <svetoslav@neykov.name>
To:     "'Alexander Shishkin'" <alexander.shishkin@linux.intel.com>,
        "'Ralf Baechle'" <ralf@linux-mips.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Gabor Juhos'" <juhosg@openwrt.org>,
        "'John Crispin'" <blogic@openwrt.org>,
        "'Alan Stern'" <stern@rowland.harvard.edu>,
        "'Luis R. Rodriguez'" <mcgrof@qca.qualcomm.com>
Cc:     <linux-mips@linux-mips.org>, <linux-usb@vger.kernel.org>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name> <87k3pvxkn8.fsf@ashishki-desk.ger.corp.intel.com> <078801ce142f$0108dea0$031a9be0$@neykov.name> <878v6bxhbd.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <878v6bxhbd.fsf@ashishki-desk.ger.corp.intel.com>
Subject: RE: [PATCH 0/5] Chipidea driver support for the AR933x platform
Date:   Tue, 26 Feb 2013 16:54:50 +0200
Message-ID: <078901ce1431$3bcc4980$b364dc80$@neykov.name>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
thread-index: AQGDG6p+wHZ3zGBMHoZ7+PlD69kkYAF6L3a2AO2krxMBvH6/M5kBBuvw
Content-Language: bg
X-Gm-Message-State: ALoCoQkqG/eurzN4XAGLO0bnQux8s7ZQkvM7q1kjoYHuiZnVhdQKXWy/ikkMe1r6VbHsVdc9RuDH
X-archive-position: 35825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svetoslav@neykov.name
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

>Great, thanks!
>Looks like this patchset will need some synchronization with Sacha's
>dr_mode/phy_mode patchset, but I presume you're aware of that.

Yes, I will base the next patch on the existing changes, thanks for bringing
that up.

Regards,
Svetoslav.
