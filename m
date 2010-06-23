Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jun 2010 17:52:19 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:51524 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491975Ab0FWPwM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jun 2010 17:52:12 +0200
Received: by gyb11 with SMTP id 11so4458739gyb.36
        for <multiple recipients>; Wed, 23 Jun 2010 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Y8W2OoERnf/CSXcvKCYXffOuXFYcbrBHYp9ifkwkdsc=;
        b=DMYOx56Kl/WdUJwrj6zejp41Zij7swRlj089ceKSlFNSj6v8EhIA2d7RHHgXQth8Wv
         GguGwkYRbFle/NPwGlnrUk0IeLu+WwyzNe++vUhdh7PgvQ1lpy8795dupivVxv75tdBS
         dqMRlOCHMLdoOgEZTFIF/Ci9N3R7z936QREL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mixepZOew0xx1hfmyF5RFhenKvKyqbKqE9J+uZHXw+1cuS85BI3lay6ZFvzJKz8xyE
         ssdKD+dDB8e3A1IeV3nKqoL7XO/fnL6P+bdVyeBIuHTI3eOwxOMi1neibw+qgM8tXBq5
         zSY5gpCkkedNfBea34LIrBSNK2g8dpW16cGII=
MIME-Version: 1.0
Received: by 10.91.135.11 with SMTP id m11mr4854781agn.2.1277308324110; Wed, 
        23 Jun 2010 08:52:04 -0700 (PDT)
Received: by 10.231.183.5 with HTTP; Wed, 23 Jun 2010 08:52:03 -0700 (PDT)
In-Reply-To: <BE430C874DBA6841A75E65151DCC6E1C04076696@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
References: <BE430C874DBA6841A75E65151DCC6E1C0407668F@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
        <AANLkTimHTt3jCTPrlIDAkdDc8WheBf7bdEThk3JO8yNO@mail.gmail.com>
        <4C126D2A.6040305@caviumnetworks.com>
        <4C127358.3030905@paralogos.com>
        <AANLkTikIur8HkXppazHT7AT2oUkNz2Mf3qvDZiLR-r25@mail.gmail.com>
        <BE430C874DBA6841A75E65151DCC6E1C04076696@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
Date:   Wed, 23 Jun 2010 17:52:03 +0200
Message-ID: <AANLkTildDzABHdIOwoQ4_NLv12NfGPfMVXCcl-SflW6V@mail.gmail.com>
Subject: Re: soft-float
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Jabir M <Jabir_M@pmc-sierra.com>
Cc:     "Kevin D. Kissell" <kevink@paralogos.com>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16087

On Wed, Jun 23, 2010 at 1:25 PM, Jabir M <Jabir_M@pmc-sierra.com> wrote:
> Coming back to correctnes , I ran paranoia.c [1] for verification and I got following result
>
> "No failures, defects nor flaws have been discovered.
> Rounding appears to conform to the proposed IEEE standard P754.
> The arithmetic diagnosed appears to be Excellent!"

Well, your toolchain seems to work as intended, and mine just sucks :)

Thanks,
        Manuel
