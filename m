Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 18:31:04 +0100 (CET)
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37282 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011406AbcAYRbCVcJ5p convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 18:31:02 +0100
Received: by mail-wm0-f41.google.com with SMTP id n5so91747300wmn.0;
        Mon, 25 Jan 2016 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=26bld2CZdbXe9ADQYbrwfvgMPXLjyo0OeFxZqeA1IgE=;
        b=wASXMd6gUf0y9GmeTF1LxDXfMeElEtdnsVxw/tEW2CwIf8ndDwHj9APXtWfj1lF9dL
         cBDlEzPTghipNIQbs0+LaA5v1o3AO4fLSFjpTQgdrYG7F7+mJ5hVm2zHVP9ojypFEOk0
         QLf+QBPPzfee/7n3lwxcDL32F9AgsINhzBYEoPnMeI3Uk7L9lr6fBIJ35oaBptYmu8Fi
         tbIaC/j+bpicBI7z8u2HF/UAia6gp1DEudAczUtfosWj7Rmgb8RH7MptUPvunbSm3ACf
         pgwh1iQ0kLghLnkRywySpkTTdxdl7Yuk4gsU6sdfD7woxDwPX3QKH7Iq6VfJN04hPiwo
         gW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=26bld2CZdbXe9ADQYbrwfvgMPXLjyo0OeFxZqeA1IgE=;
        b=e8HYFBxNL/jNEIdzbhcwvPm2Zz+ciYzrGt3YmbMA4n4BDCwiOz4VhJQxaUVl/T3lTp
         TY/hJRdp+oWDVnGifk0C/Czs/BS5hWw3FhlYVnO4IUZZu7Ft1zDgGoRTfuB0I5LqQW8w
         8HTubTLGQ4ai9vfgXPCOQGNA7i9h9cjnCqjv807PHLypct1P5SzBbpnOJgQzRDk/1CzL
         5c7aFp5ZUmmn0SDF9OJATihe6gdMWbOCw2J3HB1k9/CPFWhjEhNru08Cz3T6Y26kBgoF
         978tYqvtJHwa/5ZIAoRgX/ts8AYYy7hH4GkubduIH8UE3R+rbvcNvpPTdZVCOT+iRho5
         SziQ==
X-Gm-Message-State: AG10YORaOpuhHGnrFbNd/YrN8jlqMoFYHqLAh0XdbFJgrevzxwHJOaMgZc7pbCqxtbVGadjwBiDOHzIUd//Xkw==
X-Received: by 10.194.203.168 with SMTP id kr8mr18251978wjc.168.1453743057117;
 Mon, 25 Jan 2016 09:30:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.91.208 with HTTP; Mon, 25 Jan 2016 09:30:17 -0800 (PST)
In-Reply-To: <E484D272A3A61B4880CDF2E712E9279F45D179FA@HHMAIL01.hh.imgtec.org>
References: <1452189189-31188-1-git-send-email-mst@redhat.com>
 <CAAG0J995iCNwdN6PpuJfzo+TVWNXR3UVqS9v-4HXbryyvMn+=w@mail.gmail.com>
 <E484D272A3A61B4880CDF2E712E9279F45D04AA7@HHMAIL01.hh.imgtec.org>
 <CAJ1xhMWth4kNuEkuVEUiUEz=d_9dmKxh0+Z_GrRcKB+F72W91w@mail.gmail.com> <E484D272A3A61B4880CDF2E712E9279F45D179FA@HHMAIL01.hh.imgtec.org>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Mon, 25 Jan 2016 19:30:17 +0200
Message-ID: <CAJ1xhMVbxoag7psNg+5L6AmL4WYXKyBYNuVGjJcfqe6Km_10SQ@mail.gmail.com>
Subject: Re: [PATCH] ld-version: fix it on Fedora
To:     Daniel Sanders <Daniel.Sanders@imgtec.com>
Cc:     James Hogan <James.Hogan@imgtec.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <alexander.kapshuk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.kapshuk@gmail.com
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

On Mon, Jan 25, 2016 at 12:49 PM, Daniel Sanders
<Daniel.Sanders@imgtec.com> wrote:
>
> > From: Alexander Kapshuk [alexander.kapshuk@gmail.com]
> > Sent: 23 January 2016 14:41
> > To: Daniel Sanders
> > Cc: James Hogan; Michael S. Tsirkin; LKML; Michal Marek; linux-kbuild@vger.kernel.org; Linux MIPS Mailing List; Ralf Baechle
> > Subject: Re: [PATCH] ld-version: fix it on Fedora
> >
> > On Wed, Jan 13, 2016 at 7:30 PM, Daniel Sanders <Daniel.Sanders@imgtec.com<mailto:Daniel.Sanders@imgtec.com>> wrote:
> > Hi,
> >
> > The version number that's giving me problems is 2.24.51.20140217 which ld-version.sh converts to 2036931700 (20000000+2400000+510000+2014021700).
> >
> > At the moment, I'm wondering whether we really need to handle more than three version number components. Another thought is that the comparison could be inside ld-version.sh (or a replacement) so that it can compare the array of version components directly instead of using a constructed integer as a proxy.
> >
> > > -----Original Message-----
> > > From: james@albanarts.com<mailto:james@albanarts.com> [mailto:james@albanarts.com<mailto:james@albanarts.com>] On Behalf Of
> > > James Hogan
> > > Sent: 13 January 2016 17:06
> > > To: Michael S. Tsirkin
> > > Cc: LKML; Michal Marek; linux-kbuild@vger.kernel.org<mailto:linux-kbuild@vger.kernel.org>; Linux MIPS Mailing
> > > List; Ralf Baechle; Daniel Sanders
> > > Subject: Re: [PATCH] ld-version: fix it on Fedora
> > >
> > > Cc'ing Daniel, who has hit further breakage due to unusual version numbers.
> > >
> > > On 7 January 2016 at 17:55, Michael S. Tsirkin <mst@redhat.com<mailto:mst@redhat.com>> wrote:
> > > > On Fedora 23, ld --version outputs:
> > > > GNU ld version 2.25-15.fc23
> > > >
> > > > But ld-version.sh fails to parse this, so e.g.  mips build fails to
> > > > enable VDSO, printing a warning that binutils >= 2.24 is required.
> > > >
> > > > To fix, teach ld-version to parse this format.
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com<mailto:mst@redhat.com>>
> > > > ---
> > > >
> > > > Which tree should this be merged through? Mine? MIPS?
> > > >
> > > >  scripts/ld-version.sh | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
> > > > index 198580d..25d23c8 100755
> > > > --- a/scripts/ld-version.sh
> > > > +++ b/scripts/ld-version.sh
> > > > @@ -2,6 +2,8 @@
> > > >  # extract linker version number from stdin and turn into single number
> > > >         {
> > > >         gsub(".*)", "");
> > > > +       gsub(".*version ", "");
> > > > +       gsub("-.*", "");
> > > >         split($1,a, ".");
> > > >         print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
> > > >         exit
> > > > --
> > > > MST
> > > >
> >
> > Is this the output you're looking for?
> >
> > % echo 'GNU ld version 2.25-15.fc23' |
> > > awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
> > > match($0, /[0-9]+([.]?[0-9]+)+/)
> > > bin=substr($0,RSTART,RLENGTH)
> > > split(bin, a, ".")
> > > print a[1]*10000000 + a[2]*100000 + a[3]*10000}'
> > 22500000
> >
> > % echo 2.25.1.20140217 |
> > > awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
> > > match($0, /[0-9]+([.]?[0-9]+)+/)
> > > bin=substr($0,RSTART,RLENGTH)
> > > split(bin, a, ".")
> > > print a[1]*10000000 + a[2]*100000 + a[3]*10000}'
> > 22510000
> >
> > awk parsing code taken from ver_linux:
> > /usr/src/linux/scripts/ver_linux:28,33
> > ld -v 2>&1 |
> > awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
> >     match($0, /[0-9]+([.]?[0-9]+)+/)
> >     printf("Binutils\t\t%s\n",
> >     substr($0,RSTART,RLENGTH))
> > }'
> >
>
> It's close. That code doesn't quite work for my version number because the third component has two
> digits and overflows into the second component in the proxy integer:
> $ echo 2.24.51.20140217 |
> > awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
> > match($0, /[0-9]+([.]?[0-9]+)+/)
> > bin=substr($0,RSTART,RLENGTH)
> > split(bin, a, ".")
> > print a[1]*10000000 + a[2]*100000 + a[3]*10000}'
> 22910000
>
> but adding a zero to the first two scale factors, or removing one from the third works for me.
> $ echo 2.24.51.20140217 | awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
> > match($0, /[0-9]+([.]?[0-9]+)+/)
> > bin=substr($0,RSTART,RLENGTH)
> > split(bin, a, ".")
> > print a[1]*100000000 + a[2]*1000000 + a[3]*10000}'
> 224510000
> $ echo 2.24.51.20140217 | awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
> > match($0, /[0-9]+([.]?[0-9]+)+/)
> > bin=substr($0,RSTART,RLENGTH)
> > split(bin, a, ".")
> > print a[1]*10000000 + a[2]*100000 + a[3]*1000}'
> 22451000


I put the latter of the two methods that worked for you it into a
script, shown below:

#!/usr/bin/awk -f
# extract linker version number from stdin and turn into single number

/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
    match($0, /[0-9]+([.]?[0-9]+)+/)
    ver=substr($0,RSTART,RLENGTH)
    split(ver, a, ".")
    print a[1]*10000000 + a[2]*100000 + a[3]*1000
    exit
}

And tried it out on the following input:

% echo 2.24.51.20140217 | ld-version.sh
22451000
% echo 'GNU ld version 2.25-15.fc23' | ld-version.sh
22500000
