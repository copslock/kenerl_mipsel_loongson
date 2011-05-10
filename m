Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2011 21:07:28 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:57720 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491029Ab1EJTHZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2011 21:07:25 +0200
Received: by wwb17 with SMTP id 17so5994052wwb.24
        for <multiple recipients>; Tue, 10 May 2011 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jeHDt++L+o5mWVl6V9Vi4nM5Gbl+VXb5OzHLmY65RN4=;
        b=QIYAdl8d48Dqm40TxYg/rpgZVpKXPYp/nSb5tilnODI31nfF8Bm5ltmlxjar9U47vH
         KX2/jroLrIFzTQ+8WwKYOIv8OV3m8xP3NBeOGu6w5heDYDgQ3PqxXQvt3VEEefSy/qTP
         VMgvy7znqqK2ShIDXEWIax7g7VaQykZO5P6yM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Twl+UiIXrBUuhWLHtWhmPSzZf67yPuIZxcnQSgvgiLTEGx6Mjz2sGa3GZC35ghPWIl
         QSF/1PVYMHSrM+s1LcDYNA4ru3vsIISMK4cOeDt6gkMU5nhPqpaIteFdSZbGqCvtxU4S
         +diSPUNqS/XJ2frr50sJp46FEE7lnrZEBl72M=
MIME-Version: 1.0
Received: by 10.216.140.147 with SMTP id e19mr8557624wej.49.1305054439500;
 Tue, 10 May 2011 12:07:19 -0700 (PDT)
Received: by 10.216.49.211 with HTTP; Tue, 10 May 2011 12:07:19 -0700 (PDT)
In-Reply-To: <20110510150238.GI21768@linux-mips.org>
References: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
        <1304844140-3259-10-git-send-email-manuel.lauss@googlemail.com>
        <20110510150238.GI21768@linux-mips.org>
Date:   Tue, 10 May 2011 21:07:19 +0200
Message-ID: <BANLkTimHH3+exYa02NA1R7F3mnQaSZ8sqw@mail.gmail.com>
Subject: Re: [PATCH 9/9] MIPS: Alchemy: clean up GPIO registers and accessors
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, May 10, 2011 at 5:02 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Thanks, queued for 2.6.40 - but you really should cc the watchdog folks, too!

Thank you.  Yesterday I split some of the patches in this series; among them is
a stand-alone version of the mtx-1 watchdog patch which I sent to the watchdog
maintainer and list.

Manuel
