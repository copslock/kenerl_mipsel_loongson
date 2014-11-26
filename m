Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 14:15:20 +0100 (CET)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45557 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007196AbaKZNPSuyk2C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 14:15:18 +0100
Received: by mail-ie0-f174.google.com with SMTP id rl12so2575740iec.33
        for <linux-mips@linux-mips.org>; Wed, 26 Nov 2014 05:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=bwhrYL0Ji8IFRatVio5WRkn0asZFY3ma+VOyEwFtA0E=;
        b=CljGFPPZwp6j9IFfyMWbmvIsCwl6Fa+DlRJNdOXopOctYp/a+Cxt4mlEF46MfOIFWE
         XtwGyhO16iM8mX8BmxPU0wSKn5srbRDlJ6OxWTpXM7J20ZIjBiWoZ20ndq2i7qu3K8Q4
         fJ3F0ArOx50wP4uOmVZs7P+lphBwBEFqkDredREl6wKgHNvGFBUcTRwHfTybxwEtzWjY
         QtdZvk8mXbFpixEPEUXnL2QV42kvHm0iXXj78UkN+dV7JmJwu5IAHbGgz5yKPq/ChhEA
         5GBK1dDSBblmpHpAM19tk1XDRBJ+I/qC12OjlmrHF28UNmFL6hf83a1wUs4deXLIqKE8
         WtiQ==
X-Gm-Message-State: ALoCoQnKsyon6mY4n9Z5goeeO13rAGI3MlQqW4jfU+ScVbs5ltCPA5ge5iuE97xuPUneUmGj10mo
X-Received: by 10.50.78.164 with SMTP id c4mr8373330igx.1.1417007712808; Wed,
 26 Nov 2014 05:15:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.91.35 with HTTP; Wed, 26 Nov 2014 05:14:52 -0800 (PST)
In-Reply-To: <20141125211116.GA9997@kroah.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <20141125151018.359EAC44343@trevor.secretlab.ca> <20141125173859.GA27287@kroah.com>
 <20141125211116.GA9997@kroah.com>
From:   Grant Likely <grant.likely@linaro.org>
Date:   Wed, 26 Nov 2014 13:14:52 +0000
X-Google-Sender-Auth: 7QX5monwEO-RwonRqCpliXps3A8
Message-ID: <CACxGe6uifCPz6RM59MVODWo2WGoVBMWSFzmL9Uz3AVJ0C9-hig@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO
 accesses via DT
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44468
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

On Tue, Nov 25, 2014 at 9:11 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Nov 25, 2014 at 09:38:59AM -0800, Greg KH wrote:
>> On Tue, Nov 25, 2014 at 03:10:18PM +0000, Grant Likely wrote:
>> > On Mon, 24 Nov 2014 15:36:15 -0800
>> > , Kevin Cernekee <cernekee@gmail.com>
>> >  wrote:
>> > > My last submission attempted to work around serial driver coexistence
>> > > problems on multiplatform kernels.  Since there are still questions
>> > > surrounding the best way to solve that problem, this patch series
>> > > will focus on the narrower topic of big endian MMIO support on serial.
>> > >
>> > >
>> > > V2->V3:
>> > >
>> > >  - Document the new DT properties.
>> > >
>> > >  - Add libfdt-based wrapper, to complement the "struct device_node" based
>> > >    version.
>> > >
>> > >  - Restructure early_init_dt_scan_chosen_serial() changes to use a
>> > >    temporary variable, so it is easy to add more of_setup_earlycon()
>> > >    properties later.
>> > >
>> > >  - Make of_serial and serial8250 honor the new "big-endian" property.
>> > >
>> > >
>> > > This series applies cleanly to:
>> > >
>> > > git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux.git devicetree/next-overlay
>> > >
>> > > but was tested on the mips-for-linux-next branch because my BE platform
>> > > isn't supported in mainline yet.
>> >
>> > For the whole series:
>> > Acked-by: Grant Likely <grant.likely@linaro.org>
>> >
>> > Greg, which tree do you want to merge this through? My DT tree, or the
>> > tty tree?
>>
>> I can take these through my tty tree, thanks.
>
> I take that back, it doesn't apply to my tty tree due to changes in the
> of codebase.  So feel free to take all of these through your DT tree
> please:
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied all 7 patches. Thanks.

g.
