Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 04:53:04 +0200 (CEST)
Received: from mail-qa0-f49.google.com ([209.85.216.49]:33188 "EHLO
        mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903637Ab2DJCwr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 04:52:47 +0200
Received: by qafi29 with SMTP id i29so1866199qaf.15
        for <multiple recipients>; Mon, 09 Apr 2012 19:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RqFUOSowunAume4SbSisqFdnXlD2YBzpofPHsb1Fmfw=;
        b=mTstv4UVjJr7pIJqHRKjRyPq94gE60QufMQGkYeor2NHAn5sO++MF+66AvuBQlBXGQ
         HlB0X/uvOXBNwm9z7/JKbEPQ6eRFob4YPkX7+33Hrni8GG2T34fyc8+syoTweMnF57Fj
         Z4f/jIqlyFQe8HtaKStj0fR7kypu6ZckE3TDmRmb7SDxklMRr8id/9hndWMjdVmKv7Os
         Js8IJfJBevI7Ntu2KAYct6gle6KoPSo7JDQnJmHrZEUMQ/zpKQk3dOVRTz+y4F19bXXE
         EOknRv1BPoYevpXzeRH+d69WsFcQUTN09D5fXSrmId5ySadwt5CLch0ab06o4TWEOhR1
         2RjQ==
MIME-Version: 1.0
Received: by 10.229.135.146 with SMTP id n18mr3601339qct.139.1334026361738;
 Mon, 09 Apr 2012 19:52:41 -0700 (PDT)
Received: by 10.224.125.69 with HTTP; Mon, 9 Apr 2012 19:52:41 -0700 (PDT)
In-Reply-To: <1333988075-1289-1-git-send-email-sjhill@mips.com>
References: <1333988075-1289-1-git-send-email-sjhill@mips.com>
Date:   Mon, 9 Apr 2012 19:52:41 -0700
Message-ID: <CAJiQ=7A-Bmn9ULb3+YXaXgYTKiHZm1Dbsd-NQBjeL0TLjKAafQ@mail.gmail.com>
Subject: Re: [PATCH] Revert fixrange_init() limiting to the FIXMAP region.
From:   Kevin Cernekee <cernekee@gmail.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Leonid Yegoshin <yegoshin@mips.com>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 32917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Apr 9, 2012 at 9:14 AM, Steven J. Hill <sjhill@mips.com> wrote:
> This patch reverts 464fd83e841a16f4ea1325b33eb08170ef5cd1f4 which
> may not take calculate the right length while taking into account
> page table alignment by PMD.

If the logic is incorrect, I'd like to fix it.  Would you be able to
provide a test case that breaks the current head of tree?

Thanks.
