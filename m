Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2017 09:03:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28491 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993302AbdHAHDfqCVzZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Aug 2017 09:03:35 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9CF9E19D81FD8;
        Tue,  1 Aug 2017 08:03:26 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 1 Aug
 2017 08:03:29 +0100
Subject: =?UTF-8?Q?Re:_rying_to_build_for_my_actiontec_wcb3000n_/_mips-linux?=
 =?UTF-8?Q?-gcc:_error:_unrecognized_argument_in_option_=e2=80=98-march=3d52?=
 =?UTF-8?B?ODHigJk=?=
To:     Colin Williams <colin.williams.seattle@gmail.com>
CC:     <linux-mips@linux-mips.org>
References: <CAPXXXSAmkdF3XnZGCvkH3AEnp4h4KC3u4ooyhX9GXZXh8zoQNQ@mail.gmail.com>
 <d90545e9-1dd1-b75d-cd33-0fa64314d397@imgtec.com>
 <CAPXXXSDNbJ2M2NWjkLghWsr05m94bJPXUVndxiAWFU5Nxp3uPg@mail.gmail.com>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <4ba6a9ee-90aa-8c5e-7b32-b9462f5d9415@imgtec.com>
Date:   Tue, 1 Aug 2017 09:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPXXXSDNbJ2M2NWjkLghWsr05m94bJPXUVndxiAWFU5Nxp3uPg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Colin,

On 31.07.2017 17:00, Colin Williams wrote:
> Hi, thanks for the response. I first tried using docker to build, but it 
> appears to use the same kernel version that the host uses. Then the 
> instructions suggest getting the kernel headers using uname -r.  I'm 
> going to assume it's using the Ubuntu kernel for the build?

(please note that my comments are based on my experience with various 
cross-compilation systems, not based on using this one)
That shouldn't be the case. Some libraries/utilities even when 
cross-compiled, require that you first build host variants of those 
utilities. Hence I presume the requirement of having eg libssl-dev on 
your host, or the host's kernel headers. They wouldn't be directly used 
for the target builds, but they might be required to build some tools 
used for building the target filesystem.

> At the moment I've been trying to build on Debian, since Docker didn't 
> work out. But maybe an Ubuntu VM would work best, because it wouldn't 
> share kernels. However I think there should be a way to cross compile. 
> Also it doesn't seem to mention the kernel version, instead Ubuntu LTS. 

The kernel version is most likely irrelevant here. The fact they mention 
Ubuntu 12.04 LTS is simply because that's where it's been tested. I 
don't expect anything special about it, but various linux distribution 
may ship different versions/variants of standard gnu utils and as a 
result even a trivial app like 'diff' in one linux variant may accept 
some non-standard commandline arguments that a 'diff' in a different 
linux release wouldn't and could make the build fail.
In fact that's probably what may be happening here - just for a test I 
started a build following the readme instructions on my machine (ubuntu 
16.04) and it failed with an error in wget, which looks like caused by 
some wrong arguments.

> A little concerned regarding the kernel version. Am I right they are 
> installing the Ubuntu kernel headers to use for the firmware target? If 
> so isn't that strange because an LTS release has many kernel versions, 
> and the instructions use uname?

No, the kernel for the target is in the release package: 
WECB-NCS-GPL/rtl819x/linux-2.6.30.


I think the main source of your problem (although potentially not the 
only one) is that you have mips-linux-gcc in your $PATH and this is 
something that this build system doesn't expect - and as a result it 
uses your Debian's mips-linux-gcc rather than the one from 
WECB-NCS-GPL/rtl819x/toolchain/

Marcin
