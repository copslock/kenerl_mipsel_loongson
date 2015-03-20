Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Mar 2015 00:48:45 +0100 (CET)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34237 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009289AbbCTXso20AV4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Mar 2015 00:48:44 +0100
Received: by wibg7 with SMTP id g7so799286wib.1
        for <linux-mips@linux-mips.org>; Fri, 20 Mar 2015 16:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=CyTR7sGWsoxUOUUjhnITUIMvJL6gkLjVbA/YsCovb/U=;
        b=Z141en6AlyQg5OYK/a8gCGIiJZt1aS/PEmGVEsvLDSKp2EYgYHpIESivPK3AiiW4lJ
         f/NYdA69tedVW+T3RGCtx/tzbnV36w2ks3c6lfXbxqlAGotHKhbWJ9N0FgpdmxYgUHFy
         v+TyvUqISLtM/GMsjpaa/5znhVK9lohEoxha4t11fh9dd071MDQsKX1/bpmH4AgQAqRt
         cv0kvO4cxM5ENcSsbY2s7B7jjSs33hNSCZ0nHSNTNpp75clHwRfImFhW8KZKUUJ27ES1
         XtNe/nl3idwcUtSFe56J0IHXfmpkdHxGk5GC7tQnjZTWB4ngbKtD7zGAjjCwCuEbc82t
         TJyw==
X-Gm-Message-State: ALoCoQmlrEK3Sx8pFjx3JhOzjpMyadsotIlIL3r1Hnr4MQN1bc4jLvWtd/DdEZ6iG5Tb5ZCrkZ+p
X-Received: by 10.180.109.70 with SMTP id hq6mr397860wib.16.1426895318695;
        Fri, 20 Mar 2015 16:48:38 -0700 (PDT)
Received: from trevor.secretlab.ca (host86-162-255-95.range86-162.btcentralplus.com. [86.162.255.95])
        by mx.google.com with ESMTPSA id n6sm8372233wjy.8.2015.03.20.16.48.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 16:48:37 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 1B6A3C407F7; Fri, 20 Mar 2015 23:48:36 +0000 (GMT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V3 3/7] of: Document {little,big,native}-endian bindings
To:     Kevin Cernekee <cernekee@gmail.com>,
        Peter Hurley <peter@hurleysoftware.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
In-Reply-To: <CAJiQ=7CDAifvcMkrAsseXHHC_GGMJg-+UiWVY03JAzDqSFzi+g@mail.gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
        <1416872182-6440-4-git-send-email-cernekee@gmail.com>
        <54F4624D.6000909@hurleysoftware.com>
        <CAJiQ=7DQ6CRWddii_9HZqH0a_1ixos6FBQRzb+HM+YAh1jmkBA@mail.gmail.com>
        <54F48B03.5040205@hurleysoftware.com>
        <CAJiQ=7CKE5Nw=maewN_ChkySh1NReoUnddLO_ohOJQfwo_FXAg@mail.gmail.com>
        <54F4A1B6.8030701@hurleysoftware.com>
        <CAJiQ=7CDAifvcMkrAsseXHHC_GGMJg-+UiWVY03JAzDqSFzi+g@mail.gmail.com>
Date:   Fri, 20 Mar 2015 23:48:36 +0000
Message-Id: <20150320234836.1B6A3C407F7@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Mon, 2 Mar 2015 10:57:41 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> On Mon, Mar 2, 2015 at 9:45 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> >> This doesn't change the behavior of pre-existing drivers that
> >> implement the *-endian properties in a different way.  There are not
> >> many of these drivers and they can be documented as special cases.
> >
> > Yeah, ok, as long as there's no expectation that existing drivers
> > meet this criteria when they add big-endian support.
> 
> The intention is to make it easy for existing drivers with LE register
> accesses (i.e. mostly drivers taken from an x86 + PCI environment) to
> work on systems with native to BE register accesses.  8250 and USB are
> the first two examples of this.

I think the right solution here is to drop any specified default in the
common properties binding and replace with something like, "If a binding
supports these properties, then that binding should also specify the
default if none of these properties are present. In such cases,
little-endian is the preferred default, but it is not a requirement"

g.
