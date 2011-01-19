Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 21:45:18 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:65428 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491044Ab1ASUpP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jan 2011 21:45:15 +0100
Received: by vws5 with SMTP id 5so570125vws.36
        for <multiple recipients>; Wed, 19 Jan 2011 12:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=uFXEAugw2BaHWUDOHGQ2xU4pCi4V9z4Jo/QS9V2St1k=;
        b=AwU0doBvk1QWBifGSF6yyjIGQ3kBnB2VaeO3lK0yagVS8Qy9f6QJe1WpUwkh5WY7sN
         RSLa754oksvIghT5Avfz+YHuAEqCr9GfMblJ9Gi8e3xJttV+mlDNRVIbg63hLh2rNlgj
         vz90QhZd4sZcWXA1xYQJs7KHUN9ukkMF3FsE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=UCphZkeghW5ZGD1ImCeBQlYu1ek5TIMSlNcpwisthOGdAUj4DuoqKsYriWSmp9MUzw
         k9zZztL4uVIHctYC24NzmePASJCs3QSYyS8C4lgKSX/V5iihaEQqbBg5h/GmZPQX/oNg
         jhDz7hvan/XDZ9hbwSCfzLhzwWooqyToK5WJU=
Received: by 10.229.85.208 with SMTP id p16mr991457qcl.71.1295469907852; Wed,
 19 Jan 2011 12:45:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.39.9 with HTTP; Wed, 19 Jan 2011 12:44:47 -0800 (PST)
In-Reply-To: <4D3743FF.1080201@caviumnetworks.com>
References: <1293502077-9196-1-git-send-email-ddaney@caviumnetworks.com>
 <1293502077-9196-3-git-send-email-ddaney@caviumnetworks.com>
 <AANLkTinZZ2TziwkiBfhqV-3-VfXwU+EPx3OHsnTRVChT@mail.gmail.com>
 <4D373E5B.5010303@caviumnetworks.com> <AANLkTi=aZSwQCVudjZrUoOZYGJscER8R3vOsRcgadw-_@mail.gmail.com>
 <4D3743FF.1080201@caviumnetworks.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 19 Jan 2011 21:44:47 +0100
Message-ID: <AANLkTimfmvrBfGY1AAuGky3aKKWqxuDiPak3jVc_9Dvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Optimize TLB handlers for Octeon CPUs
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips

On 19/01/2011, David Daney <ddaney@caviumnetworks.com> wrote:
> It is a bug in GCC-4.3.  The proper fix is to add 'return 0;' after that
> BUG() statement.
>
> I will prepare a patch.

Yes, that works. Thanks for the quick response.

Jonas
