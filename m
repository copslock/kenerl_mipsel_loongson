Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2010 20:40:38 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:38124 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491076Ab0GNSkd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Jul 2010 20:40:33 +0200
Received: by wyb32 with SMTP id 32so138695wyb.36
        for <linux-mips@linux-mips.org>; Wed, 14 Jul 2010 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=XjV6m97nqnD4CfXwvimvLLVM8J0z+xObUZ8n1hX+CzM=;
        b=LB0DKO2LN6ypOoMRoSIueiXw/ucVslZvh9JOn0Bf6zEF6qwy9DoaGVgoUc6GJsTe//
         rUy6xkSUkrOLGitOZJ/IQVHSbWrpjXF1Vx5B6IJ4Wn9tkodUcH18Kx5KUttdpq6Y72Hc
         POXS1oupQbSBzhMUkapDIcbiwbGwbPbdOJm9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Aq3ii5Uklo1fjVsHxtN1Gx0tUz4PdGPnM8tTcXh2QtgTSJkPcwq4gM+rkyeN7xpBUy
         pHsjLaj8xmbbq/DUt0ItouFhHgqSaqKYuKRBPvdAWGbyHXATlyp4tv0h/ycuiVX+jiD1
         81gQ2ajhjx8AHqoG3Lisrng6NPEETajMsVtYw=
MIME-Version: 1.0
Received: by 10.227.147.209 with SMTP id m17mr16638494wbv.57.1279132827460; 
        Wed, 14 Jul 2010 11:40:27 -0700 (PDT)
Received: by 10.216.80.82 with HTTP; Wed, 14 Jul 2010 11:40:27 -0700 (PDT)
In-Reply-To: <1279115243-11586-1-git-send-email-wg@grandegger.com>
References: <1279115243-11586-1-git-send-email-wg@grandegger.com>
Date:   Wed, 14 Jul 2010 20:40:27 +0200
X-Google-Sender-Auth: 5BcDDdZEDmuGuBplLkNLstee3ic
Message-ID: <AANLkTindpsjxnTgpchvuqkxBqYg3NtsP39wXq61QRR-3@mail.gmail.com>
Subject: Re: [PATCH v2] mips/alchemy: add basic support for the GPR board
From:   Florian Fainelli <florian@openwrt.org>
To:     Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-mips@linux-mips.org, Wolfgang Grandegger <wg@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

SGkgV29sZmdhbmcsCgoyMDEwLzcvMTQgV29sZmdhbmcgR3JhbmRlZ2dlciA8d2dAZ3JhbmRlZ2dl
ci5jb20+Ogo+IEZyb206IFdvbGZnYW5nIEdyYW5kZWdnZXIgPHdnQGRlbnguZGU+Cj4KPiBUaGlz
IHBhdGNoIGFkZHMgYmFzaWMgc3VwcG9ydCBmb3IgdGhlIEdlbmVyYWwgUHVycG9zZSBSb3V0ZXIg
KEdQUikKPiBib2FyZCBmcm9tIFRyYXBlemUgSVRTLgo+Cj4gU2lnbmVkLW9mZi1ieTogV29sZmdh
bmcgR3JhbmRlZ2dlciA8d2dAZGVueC5kZT4KW3NuaXBdCgo+ICsKPiArLyoKPiArICogTEVEcwo+
ICsgKi8KPiArc3RhdGljIHN0cnVjdCBncGlvX2xlZCBncHJfZ3Bpb19sZWRzW10gPSB7Cj4gKyDC
oCDCoCDCoCB7IMKgIMKgIMKgIC8qIGdyZWVuICovCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCAu
bmFtZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA9ICJncmVlbiIsCj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAuZ3BpbyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA9IDQsCj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAuYWN0aXZlX2xvdyDCoCDCoCDCoCDCoCDCoCDCoCA9IDEsCj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAuZGVmYXVsdF90cmlnZ2VyIMKgIMKgIMKgIMKgPSAibm9uZSIs
Cj4gKyDCoCDCoCDCoCB9LAo+ICsgwqAgwqAgwqAgeyDCoCDCoCDCoCAvKiByZWQgKi8KPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIC5uYW1lIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgID0gInJl
ZCIsCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCAuZ3BpbyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCA9IDUsCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCAuYWN0aXZlX2xvdyDCoCDCoCDCoCDC
oCDCoCDCoCA9IDEsCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCAuZGVmYXVsdF90cmlnZ2VyIMKg
IMKgIMKgIMKgPSAibm9uZSIsCj4gKyDCoCDCoCDCoCB9Cj4gK307CgpTaG91bGQgYmUgImdwcjpn
cmVlbiIgYW5kICJncHI6cmVkIiByZXNwZWN0aXZlbHkgdG8gZm9sbG93IHRoZSBMaW51eApMRURz
IGNsYXNzIG5hbWluZyBjb252ZW50aW9ucy4gVGhlIGRlZmF1bHQgdHJpZ2dlciBpcyBzdXBlcmZs
dW91cywKaG93ZXZlciBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIGhhdmUgdGhlIGdyZWVuIGxlZCBi
ZSBhc3NvY2lhdGVkIHdpdGgKdGhlICJkZWZhdWx0LW9uIiB0cmlnZ2VyLiBPdGhlcndpc2UsIGl0
IGxvb2tzIHZlcnkgZ29vZC4KLS0KRmxvcmlhbgo=
