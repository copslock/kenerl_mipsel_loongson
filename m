Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2016 00:13:44 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35160 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032283AbcEZWNnIZWrP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2016 00:13:43 +0200
Received: by mail-pf0-f194.google.com with SMTP id f144so3704590pfa.2;
        Thu, 26 May 2016 15:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=OZcz1bo8aLQf1smvApCxdiuQ+4A8eNqpljmNwqJaEy4=;
        b=fNi53WJ0YEuejcwDFW+PYcofqLszFyIw27URwK/fZEzm9O8P5GaRH17K8c194OP8zB
         eNFfWt6AMTbo36LF702V8oI7FA8cz7F+Pwbe2f8sJsYKNYyPUzqemuILdPXhAFe+bPFL
         AUIfofiZ80ey4743o2y7UH96N0W7uaG9+jbEhuvQcA9bJA3uqcTLIRe3cDgqJDvQTTBf
         2shRd9k9PUaj7cLBNfxLV0nrD2xg8EoUJcaUgWitK391ra6q9/Wzox2kszlsa+FwWVLU
         jMNyCyAejNtfrkRbGcF8moc4MOPIB4b2IEkfpQo+WHni1BaeidfjXcJn1MvASgs4vztz
         hg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=OZcz1bo8aLQf1smvApCxdiuQ+4A8eNqpljmNwqJaEy4=;
        b=llvqAux/GRLzY5e20ZRC917waysgXqQ5m1S3W//eVhE93KTg3wEf2h5WV0lo8Pl2PS
         yqQ3SOuL/87pHpRj1mgLMcBLuG2txd5R0w3bYEPGrXl6FDGZzSNSvUC8XVoTZCi9UNfD
         oC/BIesoFXzQDo1EFuW8d0GH9HHbutKn2DCjvnzUr8y8OX155papRjd/j76vpxIDUTf7
         sh5XnDRQHd5soOLOCCcqPeIp1RRTAJBdWfvtbXxP3zZD9F/LbaFvKkTSOg3fd1oM+7/4
         lwcunI+Ey4xC7oFCJzRBuJF2aeJvk3Y/a3OA1bLZDJey5BTLNdXgtcXzr1R9biN2D+w+
         2hvQ==
X-Gm-Message-State: ALyK8tILd5ONo9FL9Rs/ricahiqNxL7sdYw4oMT8CTpfkx0HRs/YBKgYj0RDjdEzALd4yQ==
X-Received: by 10.98.71.81 with SMTP id u78mr17300952pfa.29.1464300816508;
        Thu, 26 May 2016 15:13:36 -0700 (PDT)
Received: from dl.caveonetworks.com ([50.233.148.158])
        by smtp.googlemail.com with ESMTPSA id 17sm8356546pfa.59.2016.05.26.15.13.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2016 15:13:35 -0700 (PDT)
Message-ID: <5747750E.4090000@gmail.com>
Date:   Thu, 26 May 2016 15:13:34 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: THP broken on OCTEON?
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net> <20160525134152.GG23204@ak-desktop.emea.nsn-net.net> <57473996.7030705@gmail.com> <20160526192330.GA17985@raspberrypi.musicnaut.iki.fi>
In-Reply-To: <20160526192330.GA17985@raspberrypi.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/26/2016 12:23 PM, Aaro Koskinen wrote:
> Hi,
>
> On Thu, May 26, 2016 at 10:59:50AM -0700, David Daney wrote:
>> On 05/25/2016 06:41 AM, Aaro Koskinen wrote:
>>> On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:
>>>> I'm getting kernel crashes (see below) reliably when building Perl in
>>>> parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
>>>> Linux 4.6.
>>>>
>>>> It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
>>>> issue - disabling it makes build go through fine.
>>>
>>> Seems to be also reproducible on MIPS64/Malta/QEMU (UP, 2 GB RAM). This
>>> happened during Perl's Configure script on the first try:
>>
>> Are you sure this failure is THP related?
>
> We have used MIPS64 Malta QEMU for regular package builds many months,
> and it has never failed with THP disabled. With THP enabled builds
> fail reliably.
>
>> Also, what is the source of your rootfs (compilers, tools etc.)?
>
> Compiler is mainline GCC 4.9.3 and binutils 2.26. The whole rootfs is
> compiled from scratch (64-bit ABI).
>
> On ER Pro, I use O32 userspace and kernel compiled with GCC 6.1.0.
>
>> Will a similar config fail this way on OCTEON booted with numcores=1?
>
> Yes, just tested with ER Pro using single core, and also with just "make"
> without any parallel threads. And it failed with SIGSEGV this time:

Is it possible for you to create a root file system that substitutes 
/sbin/init with a script that does the minimal amount of system 
initialization and then runs the "make" command?

The idea being that the system without any user input of any kind would 
boot directly to the failure case.  Ideally this would be for the single 
CPU case.

With an ext2 image of that and the vmlinux file, it would be child's 
play to run in our simulator and find the cause.



>
> [  744.268063]
> do_page_fault(): sending SIGSEGV to miniperl for invalid read access from 000000000000000c
> [  744.277418] epc = 00000000004ca8e8 in miniperl[400000+19e000]
> [  744.283202] ra  = 00000000004c9e8c in miniperl[400000+19e000]
> [  744.289005]
>
> A.
>
>
