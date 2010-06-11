Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2010 20:28:55 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:56091 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492173Ab0FKS2w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jun 2010 20:28:52 +0200
Received: by iwn34 with SMTP id 34so1704204iwn.36
        for <multiple recipients>; Fri, 11 Jun 2010 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=5zy6fRjrub2yz4HFpwH/T07Yl1JktnvFCG/YKt34MZY=;
        b=X+68dRCwrow9Sd/YC4M2DkodYqjJ78itrtzHHNX/qUx9d2xGZ/KIC5nwKQcCZkthAu
         dnnVD4osfe33+QSbaqUQjkbnNJ8T8n4Ny/mFhI+cVZ9JvCovDUrc1WPPBuFzrdrUkmfq
         o6+mJR/4ZgcrhRt+oL1LmR6sIFEGSxQcwwO7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uR65LjRKfQvRaUJPxoJpLERstWmxr6hT79pLuiH5r569m1qcfRXTZPGm8VzGcUZBr2
         hNlo0EsdMkXYlKDsQh+B05u0fRIDO1PhLp73ogYWrpvU1I9bAmWO093vs7JbDLRo+tod
         v5VNqdbQIL1RZP5O0ovI5GEpjJikPZoEdSvqM=
MIME-Version: 1.0
Received: by 10.231.150.2 with SMTP id w2mr2260814ibv.37.1276280928507; Fri, 
        11 Jun 2010 11:28:48 -0700 (PDT)
Received: by 10.231.183.74 with HTTP; Fri, 11 Jun 2010 11:28:48 -0700 (PDT)
In-Reply-To: <4C127358.3030905@paralogos.com>
References: <BE430C874DBA6841A75E65151DCC6E1C0407668F@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
        <AANLkTimHTt3jCTPrlIDAkdDc8WheBf7bdEThk3JO8yNO@mail.gmail.com>
        <4C126D2A.6040305@caviumnetworks.com>
        <4C127358.3030905@paralogos.com>
Date:   Fri, 11 Jun 2010 20:28:48 +0200
Message-ID: <AANLkTikIur8HkXppazHT7AT2oUkNz2Mf3qvDZiLR-r25@mail.gmail.com>
Subject: Re:
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Jabir M <Jabir_M@pmc-sierra.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8250

On Fri, Jun 11, 2010 at 7:33 PM, Kevin D. Kissell <kevink@paralogos.com> wrote:
> An optimized, assembly-language soft-float library implementation is *much*
> faster than the kernel emulator, but I benchmarked it once upon a time
> against a portable gnu soft-float library in C, and the difference wasn't
> nearly as dramatic.

The in-kernel emulator always works.  The float conformance test app Ralf
pointed out a few weeks ago doesn't run correctly when built with a recent
softfloat gcc with any optimization higher than O0 (tested with 4.4.4, 4.3.4).
I'd take correctness over speed any day of the week...

Manuel
